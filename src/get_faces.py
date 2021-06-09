import os
import glob

import numpy as np
from PIL import Image

from mtcnn import MTCNN



def _change_coordinates(box):
    return (box[0], box[1], box[0]+box[2], box[1]+box[3])

def _crop_faces(pil_img, boxes):
  np_img = np.array(pil_img)
  H = np_img.shape[0]

  for k in range(len(boxes)):
    boxes[k] = _change_coordinates(boxes[k])
  
  faces = []
  for box in boxes:
    x0, y0, x1, y1 = box
    faces.append(np_img[y0:y1, x0:x1, :])
  return faces

def process_image(pil_img, det):
    res = det.detect_faces(np.array(pil_img))
    boxes = [face["box"] for face in res]
    return _crop_faces(pil_img, boxes)

def pad(k):
    k_string= "00000" + str(k)
    return k_string[-5:]

RAW_PATH="../data/images/raw"
PRO_PATH="../data/images/processed"
actors_dir_names = os.listdir(RAW_PATH)

detector= MTCNN()

count = 0

for dir_name in actors_dir_names:
    os.mkdir("{0}/{1}".format(PRO_PATH, dir_name))
    filenames = os.listdir("{0}/{1}".format(RAW_PATH, dir_name))

    for filename in filenames:
        try:
            raw_img = Image.open("{0}/{1}/{2}".format(RAW_PATH, dir_name, filename))
            faces = process_image(raw_img, detector)
            for face in faces:
                try:
                    Image.fromarray(face).save("{0}/{1}/face_{2}.jpg".format(PRO_PATH, dir_name, pad(count)))
                    count+=1
                except ValueError:
                    print("error croping image")
                    print("filename", filename)
                    print("face shape", face.shape)
        except IOError:
            pass
