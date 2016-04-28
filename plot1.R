#plot1.R creates plot1.png containing histogram showing distribution of
#global active power usage across 2 dates of interest

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
png("plot1.png",width=480,height=480)
with(data,hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power"))
dev.off()