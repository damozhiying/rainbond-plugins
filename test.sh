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
	iname="${d##*/}"

	(
	set -x
	docker build -t rainbond/${iname}:latest ${build_dir}
	)

	echo "                       ---                                   "
	echo "Successfully built rainbond/${iname}:latest with context ${build_dir}"
	echo "                       ---                                   "
done