#!/bin/bash

while getopts u:f:s: flag
do
    case "${flag}" in
        u) url=${OPTARG};;
        f) file=${OPTARG};;
        s) size=${OPTARG};;
    esac
done

# Download the image from the given URL
wget $url -o $file

# Resize image to the specified size
qemu-img resize $file $size
