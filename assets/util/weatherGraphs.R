## Make weather graphs
# install.packageS("rnoaa")
library(rnoaa) # weather data package
library(plyr) #rbind.fill
library(ggplot2) 
library(rlang) # is_empty fxn

# TAVG is the average temperature
# read samps.csv directly from github
samps<- read.csv("https://raw.githubusercontent.com/DEST-bio/DEST_freeze1/main/populationInfo/samps.csv")
stations<- unique(samps$stationId)
samps$collectionDate<- as.Date(samps$collectionDate) #convert all dates to date format

#start loop, length-1 to exclude Wolbachia
makePlot<- function(x){
  currentStation<- stations[x]
  index<- which(samps$stationId == currentStation)

  dates<- samps$collectionDate[index] # array of all the days of one station id
  minDate<- min(dates) # get the min date
  maxDate<- max(dates) # get the max date
  #if only one data point in the station, get a year of data around it
  if(length(dates)==1) {
   minDate<- seq(dates, length = 2, by = "-6 months")[2]
   maxDate<- seq(dates, length = 2, by = "+6 months")[2]
  }
  
  #handle if tavg exists
  if(!is_empty(data.frame(rbind.fill(ghcnd_search(stationid = currentStation, date_min = "2012-01-01", date_max = maxDate, var="TAVG")))) ){
    #get relevant data
    dat<- data.frame(ghcnd_search(currentStation, date_min = minDate, date_max = maxDate, var="TAVG"))
    colnames(dat)<- c("id","tavg","date","mflag","qflag","sflag")
    datIndex<- which(dat$date %in% dates) #subset all dates in the range to the collectionDate
    dat$tavg<- dat$tavg/10 #divide by 10 to get whole number degrees
  } else {
    #calculate the tavg if it doesn't already exist
    dat<- data.frame(ghcnd_search(currentStation,date_min = minDate, date_max=maxDate, var=c("TMAX","TMIN")))
    dat$tavg<- ((dat$tmax.tmax + dat$tmin.tmin)/2)/10 # take average and divide by 10
    dat$date<- dat$tmin.date
    datIndex<- which(dat$date %in% dates) #subset all dates in the range to the collectionDate
  }

  #create plot
  fileName<- paste0(currentStation,".jpg")
  p<- ggplot(data= dat, aes(x=date,y=tavg)) +
    geom_line(color="#69b3a2") +
    geom_point(data= dat[datIndex,], color="red", size=3) +
    labs(title=currentStation, y="Average Daily Temperature (C)", x="Date")
  p
  ggsave(fileName, plot=p, path="~/Downloads/")

}##end function 

# graphs until DGN
for(i in 1:72){
  makePlot(i)
}

#blank placeholder graph for DGN
for(i in 72:(length(stations)-1)){
  fileName<- paste0(stations[i],".jpg")
  p<-ggplot()
  ggsave(fileName,plot=p,path="~/Downloads/")
}
