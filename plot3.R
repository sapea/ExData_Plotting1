## save the dataset in my working directory
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="household_power_consumption.zip")

## unzip data and read them
HousePowerConsum<-read.table(unz("household_power_consumption.zip","household_power_consumption.txt"),
                             header=TRUE,sep=";",
                             colClasses=c(Date="character",
                                          Time="character",rep("numeric",7)),na.strings="?")

## remove dataset
rm(fileUrl)
file.remove("household_power_consumption.zip")

## set English language
Sys.setlocale("LC_TIME", "English") 

##filter data and convert the Date and Time variables into a single datetime variable
library(dplyr)
HousePowerConsumFilter<- filter(HousePowerConsum,Date=="1/2/2007" | Date=="2/2/2007")
library(lubridate)
HousePowerConsumFilter$Date<-dmy(HousePowerConsumFilter$Date)
HousePowerConsumFilter$Time<-hms(HousePowerConsumFilter$Time)
HousePowerConsumFilter$datetime<-HousePowerConsumFilter$Date+HousePowerConsumFilter$Time

## set printing plot3.png
png("plot3.png")
par(mfrow=c(1,1))
par(bg="transparent")

## create plot3.png with function plot() of Base Plotting System
with(HousePowerConsumFilter,plot(datetime,Sub_metering_1,
                                 type="n",xlab="",ylab="Energy sub metering"))

## subset data selecting  certains columns and assign lines and colors to them
with(subset(HousePowerConsumFilter,select=Sub_metering_1),
     lines(HousePowerConsumFilter$datetime,Sub_metering_1))
with(subset(HousePowerConsumFilter,select=Sub_metering_2),
     lines(HousePowerConsumFilter$datetime,Sub_metering_2,col="red"))
with(subset(HousePowerConsumFilter,select=Sub_metering_3),
     lines(HousePowerConsumFilter$datetime,Sub_metering_3,col="blue"))

## add legend
legend("topright",lty="solid",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## close the connection with graphic device
dev.off()