import os

PATH= "celeb_images/emilia_clarke/emilia_clarke_images"

file_names= os.listdir(PATH)

def pad(k):
	string = '00000' + str(k)
	return string[-5:]

for k, file_name in enumerate(file_names):
	if file_name[-4:] == '.gif':
		os.rename("{0}/{1}".format(PATH, file_name), "{0}/{1}".format(PATH, pad(k) + '.gif'))
	else:
		os.rename("{0}/{1}".format(PATH, file_name), "{0}/{1}".format(PATH, pad(k) + '.jpg'))