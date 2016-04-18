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

# Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

TypeOfSource <- NEI_ddply %>%
        filter(fips == "24510") %>%
        group_by(type, year) %>%
        summarise(Total = sum(Emissions )) %>%
        select(Year = year, Emission = Total, Type = type)

par(mar=c(5,5,4,2))
plot_TypeOfSouce <- qplot(Year, Emission, geom = "path",
                          color = Type,data= TypeOfSource)+
        ggtitle("Total Emission (PM2.5) in Baltimore City by Type/Year") +
        xlab("Year(s)") +
        ylab ("Total Emission (PM2.5)")

print(plot_TypeOfSouce)
dev.copy(png, file = "plot3.png")
dev.off()


