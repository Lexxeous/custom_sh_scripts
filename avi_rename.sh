#!/bin/bash

# Everybody Loves Raymond - 0nx01 - <episode_name>.avi ––> SnE1 <episode_name>.avi

if [ "$1" == "" ]
then
	echo "ERROR: Must provide season number as first command line argument."
	exit 1
fi

# Prefix correct season and episode numbers
count=1
for f in *; do
if [ $count -lt 10 ]
then
mv  "$f" "S$1E0$count ${f%.*}.avi"
else
mv  "$f" "S$1E$count ${f%.*}.avi"
fi
((count++))
done

# Remove unecessary middle text
for n in *; do
s1="${n:0:6}"
s2="${n:40:100}"
mv  "$n" "$s1$s2"
done