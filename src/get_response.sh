#!/bin/bash

##### ARGUMENTS & VARIABLES #####
if [[ $# -ne 5 ]] ; then
	echo "Invalid number of argument, please provide: name; surname; tv_serie (with underscores instead of spaces); total number of requests (multiple of 10)"
	exit 1
fi

name=$1
surname=$2
tv_serie=$3
total=$4

num=10
img_size="xxlarge"

api_key="AIzaSyDOpepJVudUKvGLeQjXi3yQ4cij-pLbrvw"
cx="96d805bff545968c0"

query=""
urls=()

##### ROUTINES DEFINITION #####
function get_query(){
	local name=$1
	local surname=$2
	local tv_serie=${3//_/+}

	query="${name}+${surname}+${tv_serie}"
}

function get_urls(){
	local n_request=$((total/num + 1))

	for ((i=0; i<n_request; i++)); do
		lowRange=$((${num}*i+1))
		urls+="https://www.googleapis.com/customsearch/v1\?key=${1}\&cx=${2}\&q=${3}\&num=${4}\&lowRange=${lowRange}\&searchType=image\&fileType=jpg\&imgSize=${5}\&alt=json"
	done
}

function get_response(){
	local n_request=$((total/num + 1))
	
	for ((i=0; i<n_request; i++)); do
		echo "passed ${i}"
		curl --output "../data/links/api_responses/response_{$i}.json" --url ${urls[i]}
	done 
}


##### ROUTINES CALLS #####
get_query $name $surname $tv_serie
get_urls $api_key $cx $query $num $img_size
get_response

echo $query
echo $urls