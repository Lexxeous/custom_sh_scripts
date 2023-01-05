#!/bin/bash

# This script can remove subtitle tracks, refresh the opening title based on the filename, and modify all .mkv files in a directory accordingly.
# The user must specify their intentions with input parameters or flags.
# The macOS Homebrew environment and mkvtoolnix package must be installed to run this script.

# Display documentation
if [[ $* == *-h* ]] || [[ $* == *--help* ]]; then
	echo $'\nMKV Edit Documentation:'
	echo $'  -h, --help\t\t\tDisplay documentation.'
	echo $'  -k, --keep\t\t\tKeep original MKV file(s) (will replace original(s) by default).'
	echo $'  -s, --subtitles\t\tRemove subtitle tracks.'
	echo $'  -t, --title\t\t\tRefresh the opening title, based on the current file name.'
	echo $'  -c, --clean (-s, -t)\t\tRemove subtitle tracks and refresh the opening title.'
	echo $'  -f, --file <input_file>\tSpecify a single input file.'
	echo $'  -a, --all\t\t\tApply desired changes to all MKV files in the current directory.'
	echo $'  -F, --full (-c, -a)\t\tRemove subtitle tracks and refresh the opening title for all MKV files in the current directory.'
else # if not displaying documentation, then it will try to do something

	# Check for the existance of a mkvtoolnix package version on the machine using "Homebrew"
	if brew ls --versions mkvtoolnix > /dev/null; then
  	brew ls --versions mkvtoolnix
	else
	  echo $'ERROR: You do not have any version(s) of mkvtoolnix installed. To run this script, install the package using \"brew install mkvtoolnix\".\n'
	  exit 1
	fi

	# If the user wants the "Full" treatment
	if [[ $* == *-F* ]] || [[ $* == *--full* ]]; then
		for mkvfile in *.mkv; do
			mkvmerge -o "${mkvfile::${#mkvfile}-4}"_edit.mkv --no-subtitles "$mkvfile" # remove subtitles and create temporary "*_edit.mkv" file
			rm "$mkvfile" # remove original file
			mkvpropedit "${mkvfile::${#mkvfile}-4}"_edit.mkv -e info -s title="${mkvfile::${#mkvfile}-4}" # refresh title to filename without .mkv extention
			mv "${mkvfile::${#mkvfile}-4}"_edit.mkv "$mkvfile" # rename "*_edit.mkv" file to match the original filename
		done
	else
		echo $'Invalid use of flags and/or input parameters. Use \"mkv_edit.sh -h\" or \"mkv_edit.sh --help\" to display the documentation.'
		exit 2
	fi
fi