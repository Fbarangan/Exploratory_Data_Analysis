#File Management and data download:
library(dplyr)

#Create file
if (!file.exists("RawData"))
{dir.create("RawData")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./RawData/Electric_Power_Consumption.zip")
dateDownloaded <- date()

# Unzip

#Reading data
Data <- read.table (file = "./RawData/household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, header = TRUE, skip = 0)

Data_tbl <- tbl_df(Data)
Data_tbl <- mutate(Data_tbl, NewDateTime = as.POSIXct(paste(Data_tbl$Date,Data_tbl$Time), format = "%d/%m/%Y %T"))

# Cleanup NA
Data_tbl <- filter(Data_tbl, NewDateTime >= "2007-02-01 00:00:00" & NewDateTime < "2007-02-03 00:00:00")

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

dim(Data)

#remove row 1. Label is redundant, convert to tbl format, convert date to right
#format, then filter the desired dates
rawData2 <- tbl_df(Data)
rawData2 <-  rawData2[c(2:2075260),]
rawData2$newTime <- mutate(rawData2, Date = as.POSIXct(paste(rawData2$Date, rawData2$Time), format = "%d/%m/%Y %T"))
rawData3 <- mutate(rawData2, Date = as.POSIXct(rawData2$Date, format = "%d/%m/%Y"))

rawData5 <- filter(rawData3, Date == "2007-02-01" | Date == "2007-02-02")

# convert  Global active power to numeric, then bind column back to the main data

GlobalActivePower <- as.numeric(rawData5$Global_active_power)
rawData5 <- cbind(rawData5,GlobalActivePower)


#Plot Data
par(mfrow = c(1,1))

plot(rawData5$newTime, rawData5$GlobalActivePower,
     Type = "1",
     xlab = "",
     ylab = "Global Active Power (Kilowatts)"
     )

#Copy to PNG
dev.copy(png, file = "plot1.png" )
dev.off()
