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
if [[ ! -d "../data/images" ]]; then
	mkdir "../data/images"
fi

if [[ ! -d "../data/images/raw" ]]; then
	mkdir "../data/images/raw"
fi

if [[ ! -d "../data/images/processed" ]]; then
	mkdir "../data/images/processed"
fi


cat links.txt | while read line; do   
	arr=(${line})
	folder="${arr[0]}"
	url="${arr[1]}"

	if [ ! -d "../data/images/raw/${folder}" ]; then
		mkdir "../data/images/raw/${folder}"
	fi
	curl --output "../data/images/raw/${folder}/image_${idx}.jpg" --url ${url}

	update_idx
	pad_idx
done