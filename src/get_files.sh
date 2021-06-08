#!/bin/bash
###### VARIABLES ######
folder=""
query=""
idx=0


##### ROUTINES DEFINITION #####
function update_idx(){
	idx=$((idx+ 1))
}

function get_query(){
	local filename=$1
	local parts=(${filename//_/ })
	query=${parts[1]}
}

function get_folder(){
	local parts=(${query//+/ })
	folder="${parts[0]}_${parts[1]}"
}


##### BODY #####
cat links.txt | while read line; do   
	get_query $line
	echo ${query}

	if [[ ${idx} -eq 0 ]]; then
		get_folder
		echo "passed"
	fi
	#curl --output "../data/images/raw/image_${idx}.jpg" --url $line; 
	
	update_idx

	echo ${idx}
done