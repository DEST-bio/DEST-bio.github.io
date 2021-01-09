# In the table will be printed the file name, the download link, and the location/time
# pull the location/time information from samps.csv
##  attribute/format by matching the samp name from bed.gz.csv to samps.csv

#cd into the proper folder first

#keep only the first, last, and second to last columns
## link, samp name, and file name respectively
cat bed.gz.csv |
awk -F"," '{
  print $1,","$(NF-1),","$NF
}' > temp.csv
#replace the contents of bed.gz.csv
cat temp.csv > bed.gz.csv

#In Excel, use VLOOKUP() to match the description from samps.csv to bed.gz.csv
#now create the final csv to convert to markdown
awk 'BEGIN{FS=OFS=","} {
  print $3 FS "[Download]("$1")\{: .btn .btn-purple \}" FS $4
}' bed.gz.csv > bed.gz.TOMARKDOWN.csv
# remove any unnecessary spaces with Excel "Find and Replace"
# you can delete temp.csv
# now convert to markdown
