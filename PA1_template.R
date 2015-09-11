dataset=read.csv("activity.csv",header=T)  #load data and remove NA value
dataset1=dataset[!is.na(dataset$steps),]
library(reshape2)
#calculate total steps by day
datamelt=melt(dataset1,id=c("date","interval"),measure.vars="steps")
totalperday=dcast(datamelt,date~variable,sum)
#histogram plotting
hist(totalperday$steps,breaks=10,xlab="Steps",main="Total Steps Per Day")
#mean and median
mm=c(mean(totalperday$steps),median(totalperday$steps))
names(mm)=c("mean","median")
print(mm)

#calculate average steps by 5-minute intervals
averageperinterval=dcast(datamelt,interval~variable,mean)
#time sequence
timeseq=1:nrow(averageperinterval)
timeseq=timeseq*5/60
#make the plot
plot(timeseq,averageperinterval$steps,type="l",xlab="5-minute interval index",
     ylab="average steps",main="average steps by 5-minute intervals")
#find the maximun value
x=averageperinterval[averageperinterval$steps==max(averageperinterval$steps),]
print(x)

#number of missing values
nanumber=nrow(dataset)-nrow(dataset1)
names(nanumber)="number of missing values"
print(nanumber)
#fill values with the mean for that 5-minute interval
newdataset=dataset
for(i in 1:nrow(newdataset)){
  if(is.na(newdataset$steps[i])){
    newdataset$steps[i]=averageperinterval[averageperinterval$interval
                                           ==newdataset$interval[i],]$steps
  }
}
#make the same hisogram and calculate the same mean and median to see 
#if there is any difference after filling missing values
datamelt1=melt(newdataset,id=c("date","interval"),measure.vars="steps")
totalperday1=dcast(datamelt1,date~variable,sum)
par(mfrow=c(1,2))
hist(totalperday$steps,breaks=10,xlab="Steps",main="Total Steps Per Day (Original")
hist(totalperday1$steps,breaks=10,xlab="Steps",main="Total Steps Per Day (New)")
mm=c(mean(totalperday$steps),median(totalperday$steps),
     mean(totalperday1$steps),median(totalperday1$steps))
names(mm)=c("mean original","median original","mean new","median new")
print(mm)

#create a factor column to identify if the date is weekend or not
newdataset$weekday=logical(nrow(newdataset))
newdataset$date=as.Date(newdataset$date)
newdataset$weekday=!weekdays(newdataset$date)%in%c("ĞÇÆÚÁù","ĞÇÆÚÈÕ")
newdataset$weekday=as.factor(newdataset$weekday)
levels(newdataset$weekday)=c("weekend","weekday")
#calculate average steps by 5-minute intervals
datamelt1=melt(newdataset,id=c("date","interval","weekday")
               ,measure.vars="steps")
averageperinterval1=dcast(datamelt1,interval+weekday~variable,mean)
#time sequence
timeseq1=1:(nrow(averageperinterval1)/2)
timeseq1=rep(timeseq1,each=2)
timeseq1=timeseq1*5/60
averageperinterval1=cbind(timeseq1,averageperinterval1)
#make the plot
library(ggplot2)
g=ggplot(averageperinterval1,aes(timeseq1,steps))
g=g+geom_line()
g=g+facet_grid(weekday~.)
g