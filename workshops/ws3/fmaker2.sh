#!/bin/bash

read -p "Enter a name of a new directory: " new_dir

if [ -d $new_dir ]; then
    echo "Directory already exists"
else
    mkdir $new_dir
    echo "$new_dir directory created."
fi

exit 0