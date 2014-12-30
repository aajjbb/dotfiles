#!/usr/bin/env bash

FILES="$(pwd)/.*"
FILES+=" $(ls)"

#my current solution to ignore backward directories
counter=0

echo $FILES

for f in $FILES
do
	((counter++))

	if [[ $counter -lt 3 ]];
	then
		continue
	fi
	
	filename=$(basename "$f")

	if [ -f $filename ];
	then
		echo "File $filename"
	elif [ -d $filename ];
	then
		echo "Directory $filename"
	fi
done
