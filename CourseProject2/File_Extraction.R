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

EmissionsByYear <- NEI_ddply %>%
        group_by(year) %>%
        summarise(Total = sum(Emissions )) %>%
        select(Year = year, Emission = Total)

# Convert to log of 10 for better visualization
EmissionsByYear$Emission <- log10(EmissionsByYear$Emission)

#Plot using Base
plot(EmissionsByYear$Year, EmissionsByYear$Emission,
      xlab= "Year",
      ylab = "Total Emission by Year",
      main = "Comparison of Total Emission (PM2.5) from 2000 to 2008",
      pch = 10)

# Plot 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

Baltimore_Emission <- NEI_ddply %>%
        filter(fips == "24510") %>%
        group_by(year) %>%
        summarise(Total = sum(Emissions )) %>%
        select(Year = year, Emission = Total)

with (Baltimore_Emission, (plot(Year, Emission,
                                xlab = "Year",
                                ylab = "Total Emission",
                                main = "Total Emission (PM2.5) for Baltimore City",
                                pch= 1)))

# Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

TypeOfSource <- NEI_ddply %>%
        filter(fips == "24510") %>%
        group_by(type, year) %>%
        summarise(Total = sum(Emissions )) %>%
        select(Year = year, Emission = Total, Type = type)

plot_TypeOfSouce <- qplot(Year, Emission, geom = "path",
                          color = Type,data= TypeOfSource)+
        ggtitle("Total Emission of PM2.5 in Baltimore City by Type by Year") +
        xlab("Year(s)") +
        ylab ("Total Emission (PM2.5)")

