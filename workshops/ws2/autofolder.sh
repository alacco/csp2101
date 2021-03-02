#!/bin/bash

mkdir $1
cd $1
touch $2
echo "The $1 directory has been created and populated with the file $2"

exit 0