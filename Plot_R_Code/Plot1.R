#File Management and data download:
if (!file.exists("RawData"))
   {dir.create("RawData")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./RawData/Electric_Power_Consumption.zip")
dateDonwloaded <- date()

# Unzip

rawData <- file()

#Reading data
Data <- read.table (file = "./RawData/household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, header = FALSE, skip = 0)

#Rename column
colnames(Data)[1] = "Date"
colnames(Data)[2] =  "Time"
colnames(Data)[3] = "Global_active_power"
colnames(Data)[4] = "Global_reactive_power"
colnames(Data)[5] = "Voltage"
colnames(Data)[6] = "Global_intensity"
colnames(Data)[7] = "Sub_metering_1"
colnames(Data)[8] = "Sub_metering_2"
colnames(Data)[9] = "Sub_metering_3"
