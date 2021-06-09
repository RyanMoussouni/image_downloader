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

for dir_name in actors_dir_names:
    if dir_name not in os.listdir(PRO_PATH):
        os.mkdir("{0}/{1}".format(PRO_PATH, dir_name))

    filenames = os.listdir("{0}/{1}".format(RAW_PATH, dir_name))

    for filename in filenames:
        try:
            raw_img = Image.open("{0}/{1}/{2}".format(RAW_PATH, dir_name, filename))
            faces = process_image(raw_img, detector)
            for face in faces:
                try:
                    face_count= len(os.listdir("{0}/{1}".format(PRO_PATH, dir_name)))
                    Image.fromarray(face).save("{0}/{1}/{2}_face_{3}.jpg".format(PRO_PATH, dir_name, dir_name, pad(face_count)))
                except ValueError:
                    print("error croping image")
                    print("filename", filename)
                    print("face shape", face.shape)
            os.remove("{0}/{1}/{2}".format(RAW_PATH, dir_name, filename))

        except IOError:
            pass
