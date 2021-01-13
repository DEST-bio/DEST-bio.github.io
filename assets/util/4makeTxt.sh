### Make the .txt files for easy link download
## Main .txt files are made by simply copy-pasting the column of links from the appropriate csv file

#cd into the proper folder first

#separate masked.sync.gz from .tbi
## First, .gz only
cat masked.sync.gz.ALL.txt | grep -v ".tbi" > masked.sync.gz.GZONLY.txt
## Then .tbi only
cat masked.sync.gz.ALL.txt | grep ".tbi" > masked.sync.gz.TBIONLY.txt

#same for SNAPE
#.gz only
cat SNAPE.monomorphic.masked.sync.gz.ALL.txt | grep -v ".tbi" > SNAPE.monomorphic.masked.sync.gz.GZONLY.txt
#.tbi only
cat SNAPE.monomorphic.masked.sync.gz.ALL.txt | grep ".tbi" > SNAPE.monomorphic.masked.sync.gz.TBIONLY.txt
