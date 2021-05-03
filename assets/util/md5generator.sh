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

#### !!! If not working, check that the txt file is properly encoded. may present issues on mac ####
#### `od -c filename.txt` to see if there's '\r' at the end of every line.
#### if so, use `tr -d '\r' filename.txt` and save the output to the file

## Now reformat to get into nice commas separated format
for file in $( cat ./1.txtFilenames.txt ); do
  awk '{if( NR % 2 != 0 ) { printf $0"," }
  else { print $0 } }' < ./MD5_$file > ./MD5_$file.csv
done

# Now copy the columns into the TOMARKDOWN csvs and convert to markdown again
