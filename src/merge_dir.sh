while getopts "p:o:d:" opt; do
	case $opt in
		p) PATH_TO_DIR=${OPTARG};;
		o) ORIGIN_DIRS=${OPTARG};;
		d) DEST_DIR=${OPTARG};;
	esac 
done

PATH_TO_DEST="${PATH_TO_DIR}/${DEST_DIR}"
ORIGIN_DIRS=(${ORIGIN_DIRS})

function rename_files(){
	local filenames=(`ls ${PATH_TO_ORIGIN}`)
	local n_files=${#filenames[@]}

	for ((j=0; j<n_files; j++)); do
		mv "${PATH_TO_ORIGIN}/${filenames[j]}" "${PATH_TO_ORIGIN}/${ORIGIN_DIR}_${j}.jpg" 
	done
}

function move_files(){
	cp -r "${PATH_TO_ORIGIN}/." "${PATH_TO_DEST}/."
}

function parse_origins(){
	n_dirs=${#ORIGIN_DIRS[@]}

	for ((i=0; i<n_dirs; i++)); do
		ORIGIN_DIR=${ORIGIN_DIRS[i]}
		PATH_TO_ORIGIN="${PATH_TO_DIR}/${ORIGIN_DIR}"
		rename_files
		move_files
	done
}

parse_origins
