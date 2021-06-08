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


PATH = "../data/links/api_responses"

with open("links.txt", "w") as f:
	files = os.listdir(PATH)
	for file in files:
		for link in get_link_gen(file):
			f.write(link + "\n")
	f.close()