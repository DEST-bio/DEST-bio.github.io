## make nFlies bar graph 
library(ggplot2)

samps<- read.csv("https://raw.githubusercontent.com/DEST-bio/DEST_freeze1/main/populationInfo/samps.csv")
stations<- unique(samps$stationId)

makeFliesPlot<- function(i){
  currentStation<-stations[i]
  dat<-samps[which(samps$stationId==currentStation),]

  fileName<- paste0(currentStation,"_NFLIES.jpg")
  p<-ggplot(data = dat, aes(x=collectionDate,y=nFlies)) + 
    geom_bar(stat="identity") +
    labs(title="Num Flies")
  p
  ggsave(fileName, plot=p, path="~/Downloads/")
}

#read in the nFlies and the date for each station
#make bar graph of nFlies on y axis and date on the x axis

for(i in 1:(length(stations)-1)){
  makeFliesPlot(i)
}
