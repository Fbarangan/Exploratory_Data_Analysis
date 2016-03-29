
#File Management and data download:
library(dplyr)

#Create file
if (!file.exists("RawData"))
{dir.create("RawData")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./RawData/Electric_Power_Consumption.zip")
dateDownloaded <- date()

# Unzip

#Reading data using read.table
Data <- read.table (file = "./RawData/household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, header = TRUE, skip = 0)

#Convert to tbl_df for easy manipulation using dplyr
Data_tbl <- tbl_df(Data)
Data_tbl <- mutate(Data_tbl, NewDateTime = as.POSIXct(paste(Data_tbl$Date,Data_tbl$Time), format = "%d/%m/%Y %T"))

# Convert the date and time
Data_tbl <- filter(Data_tbl, NewDateTime >= "2007-02-01 00:00:00" & NewDateTime < "2007-02-03 00:00:00")

dim(Data)

#Plot Data
par(mfrow = c(2,2))

with(Data_tbl, {
        plot(NewDateTime, Sub_metering_1, xlab = "", ylab = "Energy Sub Metering", type = "l")
        lines(NewDateTime, Sub_metering_2, col = "red" )
        lines(NewDateTime, Sub_metering_3, col= "blue" )
        legend("topright", col = c("Black", "Red", "Blue"), lty = 1,
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
        }
     )


#Copy to PNG
dev.copy(png, file = "plot3.png" )
dev.off()

