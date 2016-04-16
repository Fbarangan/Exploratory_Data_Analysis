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
NEI <- readRDS ("./CourseProject2/PM25_Raw_Data/PeerAssessment/summarySCC_PM25.rds")
SCC <- readRDS ("./CourseProject2/PM25_Raw_Data/PeerAssessment/Source_Classification_Code.rds")

# Turn table into dplyr
NEI_ddply <- tbl_df(NEI)
SCC_ddply <- tbl_df(SCC)

# Plot 1
# Summary of data per year, group by year, then summarize total of emmision by year using dply pipeline.
table(NEI_ddply$year)

by_Year <- group_by(NEI_ddply,year)
EmissionByYear <- summarise(by_Year, Total = sum(Emissions))


# rename

# Plot1





