#!/bin/bash
###### VARIABLES ######
folder=""
idx=00000


##### ROUTINES DEFINITION #####
function update_idx(){
	idx=$((10#${idx} + 1))
}

function pad_idx(){
	local temp="00000${idx}"
	idx=${temp:(-5):5}
}

##### BODY #####
cat links.txt | while read line; do   
	arr=(${line})
	folder="${arr[0]}"
	url="${arr[1]}"

	if [ -d "../data/images/raw/${folder}" ]; then
		curl --output "../data/images/raw/${folder}/image_${idx}.jpg" --url ${url} 
	else
		mkdir "../data/images" && mkdir "../data/images/raw" && mkdir "../data/images/raw/${folder}"
		curl --output "../data/images/raw/${folder}/image_${idx}.jpg" --url ${url}
	fi

	update_idx
	pad_idx
done