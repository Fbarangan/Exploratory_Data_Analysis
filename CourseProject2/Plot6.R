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


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl, destfile = "./PM25_Raw_Data/PeerAssessment.zip")
dateOfDownload <- date()

# Click the PeerAssessment.zip to unzip.
# 2 File are extracted:
#    Source_Classification_Code.rds
#    summarySCC_PM25.rds

# Make sure to go to the right directory

# Read  .rds file
NEI <- readRDS ("./CourseProject2/PM25_Raw_Data/PeerAssessment/summarySCC_PM25.rds")
SCC <- readRDS ("./CourseProject2/PM25_Raw_Data/PeerAssessment/Source_Classification_Code.rds")

# Turn table into dplyr
NEI_ddply <- tbl_df(NEI)
SCC_ddply <- tbl_df(SCC)

# Plot 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

 LosAngeles_VS_Baltimore <- NEI_ddply %>%
        filter(fips %in% c("06037", "24510")) %>%
        filter(type == 'ON-ROAD') %>%
        group_by(year, fips) %>%
        summarise(Total = sum(Emissions )) %>%
        select(Year = year, fips, Emission = Total)

 # Plot
plot_LosAngeles_VS_Baltimore <- qplot(Year, Emission, geom = "line",
                           color = fips ,data= LosAngeles_VS_Baltimore) +
         ggtitle("Total Emission of PM2.5 in Baltimore  Vs LA ;Type = On-ROAD by Year") +
         xlab("Year(s)") +
         ylab ("Total Emission (PM2.5)")

print(plot_LosAngeles_VS_Baltimore)
dev.copy(png, file = "plot6.png")
dev.off()
