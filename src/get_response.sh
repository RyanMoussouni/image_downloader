#!/bin/bash

##### ARGUMENTS & VARIABLES #####
if [[ $# -ne 4 && $# -ne 5 ]] ; then
	echo "Invalid number of argument (should be 4 or 5), please provide: name; surname; number of images wanted (multiple of 10, max 300); size of image (large, xlarge, xxlarge); and optionnally the tv_serie (with underscores instead of spaces)"
	exit 1
fi

name=$1
surname=$2
total=$3
img_size=$4

if [[ $# -eq 5 ]]; then
	tv_serie=$5
fi

num=10

api_key="AIzaSyDOpepJVudUKvGLeQjXi3yQ4cij-pLbrvw"
cx="96d805bff545968c0"

query=""
urls=()

##### CALLS TO THE FILE SYSTEM #####

if [[ ! -d "../data" ]]; then
	mkdir "../data"
fi
if [[ ! -d "../data/links" ]]; then
	mkdir "../data/links"
fi
if [[ ! -d "../data/links/api_responses" ]]; then
	mkdir "../data/links/api_responses"
fi
if [[ ! -d "../data/links/download" ]]; then
	mkdir "../data/links/download"
fi

##### ROUTINES DEFINITION #####
function get_query(){
	if [[ $# -eq 3 ]]; then
		local tv_serie=${3//_/+}
		query="${name}+${surname}+${tv_serie}"
	else
		query="${name}+${surname}"
	fi
}

function get_urls(){
	local n_request=$((total/num + 1))

	for ((i=0; i<n_request; i++)); do
		lowRange=$((${num}*i+1))
		urls+=("https://www.googleapis.com/customsearch/v1?key=${1}&cx=${2}&q=${3}&num=${4}&lowRange=${lowRange}&searchType=image&fileType=jpg&imgSize=${5}&alt=json")
	done
}

function get_response(){
	local n_request=$((total/num + 1))
	
	for ((i=0; i<n_request; i++)); do
		curl --output "../data/links/api_responses/response_${query}_${i}.json" --url ${urls[i]}
	done 
}


##### BODY #####

if [[ $# -eq 5 ]]; then
	get_query $name $surname $tv_serie
else
	get_query $name $surname
fi

get_urls $api_key $cx $query $num $img_size
get_response