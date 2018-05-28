#!/bin/bash

set -e
set -o pipefail

# build the changed dockerfiles
for d in $(find ./* -maxdepth 1 -type d); do
	if ! [[ -e "$d/Dockerfile" ]]; then
		echo "$d"
		continue
	fi

	build_dir="${d##./}"

	#iname="${d##*/}"
	iname=$(echo ${d##./} | tr '/' '-')

	(
	set -x
	docker build -t rainbond/plugins:${iname} ${build_dir}
	)

	echo "                       ---                                   "
	echo "Successfully built rainbond/plugins:${iname} with context ${build_dir}"
	echo "                       ---                                   "
done