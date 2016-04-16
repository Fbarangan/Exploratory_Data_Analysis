#File Management and data Download
library(dplyr)
library(ggplot2)

#get Directorory
getwd()

# file location -  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
# Create the file
if (!file.exists("PM25_Raw_Data")) {
  dir.create("PM25_Raw_Data")
}

Desktop/DataScienceCourse/Exploratory_Data_Analysis

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl, destfile = "./PM25_Raw_Data/PeerAssessment.zip")
dateOfDownload <- date()

# Click the PeerAssessment.zip to unzip.
# 2 File are extracted:
#    Source_Classification_Code.rds
#    summarySCC_PM25.rds

# need to go to the correct directory

# Read  .rds file
NEI <- readRDS ("./PM25_Raw_Data/PeerAssessment/summarySCC_PM25.rds")
SCC <- readRDS ("./PM25_Raw_Data/PeerAssessment/Source_Classification_Code.rds")


