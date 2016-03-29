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
par(mfrow = c(1,1))

plot(Data_tbl$NewDateTime , Data_tbl$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (Kilowatts)"
     )

#Copy to PNG
dev.copy(png, file = "plot2.png" )
dev.off()

