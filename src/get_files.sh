#!/bin/bash

##### CALLS TO THE FILE SYSTEM #####
if [[ ! -d "../data/images" ]]; then
	mkdir "../data/images"
fi

if [[ ! -d "../data/images/raw" ]]; then
	mkdir "../data/images/raw"
fi

if [[ ! -d "../data/images/processed" ]]; then
	mkdir "../data/images/processed"
fi

###### VARIABLES ######
actor_folder=""


##### ROUTINES DEFINITION #####
function pad_idx(){
	local temp="00000${idx}"
	idx=${temp:(-5):5}
}

##### BODY #####

cat links.txt | while read line; do   
	arr=(${line})
	actor_folder="${arr[0]}"
	url="${arr[1]}"

	if [ ! -d "../data/images/raw/${actor_folder}" ]; then
		mkdir "../data/images/raw/${actor_folder}"
	fi
	
	idx=`ls -1 ../data/images/raw/${actor_folder} | wc -l`
	pad_idx
	curl --output "../data/images/raw/${actor_folder}/image_${idx}.jpg" --url ${url}
done