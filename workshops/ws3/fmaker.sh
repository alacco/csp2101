#!/bin/bash

read -p "Enter a name of a new directory: " new_dir
mkdir $new_dir
echo "$new_dir directory created."

exit 0