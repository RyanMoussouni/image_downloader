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


PATH = "../data/links/api_responses/"

with open("links.txt", "w") as f:
	files = os.listdir(PATH)
	for file in files:
		name, surname = file.split("_")[1].split("+")[0], file.split("_")[1].split("+")[1]
		for link in get_link_gen(file):
			f.write("{0}_{1} {2}\n".format(name, surname, link))
	f.close()
	
	for file in files:
		os.remove(PATH + file)
	