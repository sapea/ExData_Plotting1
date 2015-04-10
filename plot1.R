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

## set printing plot1.png
png("plot1.png")
par(mfrow=c(1,1))
par(bg="transparent")

## create plot1.png with function hist() of Base Plotting System
with(HousePowerConsumFilter,hist(Global_active_power, main="Global Active Power",
                                 xlab="Global Active Power(kilowatts)",col="red"))

## close the connection with graphic device
dev.off()
