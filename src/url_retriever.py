import os
import json

def get_link_gen(file):
	with open(PATH + file, "r") as f:
		string = f.read()
		f.close()

	json_obj = json.loads(string)
	items = json_obj["items"]

	for item in items:
		yield item["link"]


name = "emilia_clarke\\"
PATH = "C:\\Users\\G604056\\Documents\\reconnaissance_serie\\celeb_images\\" + name

with open("links.txt", "w") as f:
	files = os.listdir(PATH)
	for file in files:
		for link in get_link_gen(file):
			f.write(link + "\n")
	f.close()