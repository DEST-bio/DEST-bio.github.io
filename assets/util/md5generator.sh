#!/bin/sh

## This script will generate the md5 hashes for each of the files on DEST.bio
## This was written to be run locally on a mac (not Rivanna)

## Insert file, read through each line, then use wget | md5 -r to get hash, output to .txt file

## cd into the assets folder first
for file in $( cat ./1.txtFilenames.txt ); do
  for line in $( cat ./$file ); do
    echo $line >> ./MD5_$file
    wget $line -O- | md5 -r >> ./MD5_$file
  done
done
