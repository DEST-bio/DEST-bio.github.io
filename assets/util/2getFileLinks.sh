## This script goes through splitlinks.csv and pulls out
## all rows that contain the desired file type

#cd into the repo first

##################
# Get bed.gz files
##################
#remove the SNAPE.complete files first
grep -v 'complete' splitlinks.csv | \
awk -F"," '{
  if( index($0,"bed.gz")!=0 ) {print $0}
}' > bed.gz.csv

##################
# Get masked.sync.gz
##################
#remove the SNAPE files first
grep -v 'SNAPE' splitlinks.csv | \
awk -F"," '{
  if( index($0,"masked.sync.gz")!=0 ) {print $0}
}' > masked.sync.gz.csv

#Now get the SNAPE.monomorphic files
grep 'SNAPE.monomorphic' splitlinks.csv | \
awk -F"," '{
  if( index($0,"masked.sync.gz")!=0 ) {print $0}
}' > SNAPE.monomorphic.masked.sync.gz.csv

##################
# Get mel.bam files
##################
#don't include mel.bam.bai
grep -v '.bai' splitlinks.csv | \
awk -F"," '{
  if( index($0,"mel.bam")!=0 ) {print $0}
}' > mel.bam.csv

###########################
# Get pipeline output links
###########################
grep -vE 'fastqc|trimmed'  splitlinks.csv | \
grep 'pipeline_output' | \
awk -F"," '{
  if( index($NF,".")==0 ){print $0}
}' > pipeline_output.csv
