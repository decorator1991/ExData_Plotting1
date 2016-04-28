#plot4.R creates plot4.png containing 4 graphs showing
#a) time-dependence of global active power usage;
#b) time-dependence of voltage usage;
#c) time-dependence of different energy sub-metering measurements;
#d) time-dependence of global reactive power usage

#1) Download file with data
if(!file.exists("household_power_consumption.txt")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url,"dataset.zip",method="curl")
        unzip("dataset.zip")
}

#2) Load data of interest (from dates 2007-02-01 and 2007-02-02)
headers <- read.table("household_power_consumption.txt",header=F,sep=";",nrows=1,stringsAsFactors = F)
data <- read.table("household_power_consumption.txt",header=F,sep=";",na.strings = "?",nrows=2880,skip=66637)
colnames(data) <- unlist(headers)
head(data)

#3) Convert Dates to date format
library(lubridate)
data <- transform(data, Date=dmy(data$Date))
data <- transform(data, Time=hms(data$Time))

#4) Add one combined variable of date and time
data$Datetime <- data$Date+data$Time

#5) Plot a graph of interest
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(data,plot(Datetime,Global_active_power,ylab="Global Active Power",type="n"))
with(data,lines(Datetime,Global_active_power,lwd=1.5))

with(data,plot(Datetime,Voltage,xlab="datetime",ylab="Voltage",type="n"))
with(data,lines(Datetime,Voltage,lwd=1))

with(data,plot(Datetime,Sub_metering_1,ylab="Energy sub metering",type="n"))
with(data,lines(Datetime,Sub_metering_1,lwd=1.5))
with(data,lines(Datetime,Sub_metering_2,lwd=1.5,col="red"))
with(data,lines(Datetime,Sub_metering_3,lwd=1.5,col="blue"))
legend("topright",lty=c(1,1),col=c("black","red","blue"),legend=colnames(data)[7:9],bty="n")

with(data,plot(Datetime,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="n"))
with(data,lines(Datetime,Global_reactive_power,lwd=1))
dev.off()