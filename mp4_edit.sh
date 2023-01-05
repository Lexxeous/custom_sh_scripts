#!/bin/bash

# This script will edit the metadata of all mp4 files in a directory.
# This script will rename all mp4 files in directory by stripping off first 33 characters.
# This script will change the title to the current filename without the extension.
# The macOS Homebrew environment and AtomicParsley package must be installed to run this script.

# Check for the existance of a AtomicParsley package version on the machine using "Homebrew"
if brew ls --versions AtomicParsley > /dev/null; then
	brew ls --versions AtomicParsley
else
  echo $'ERROR: You do not have any version(s) of AtomicParsley installed. To run this script, install the package using \"brew install AtomicParsley\".\n'
  exit 1
fi

# Check for the existance of a rename package version on the machine using "Homebrew"
if brew ls --versions rename > /dev/null; then
	brew ls --versions rename
else
  echo $'ERROR: You do not have any version(s) of rename installed. To run this script, install the package using \"brew install rename\".\n'
  exit 1
fi

rename 's/.{33}(.*)/$1/' * # rename all mp4 files in directory by stripping off first 33 characters

# Change the title to the current filename without the extension
for mp4file in *.mp4; do
	AtomicParsley "$mp4file" --title "${mp4file::${#mp4file}-4}" --overWrite
	echo $'\n'
	AtomicParsley "$mp4file" -t
done