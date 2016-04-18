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
# Plot 5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Filter Motor vehicle source = "On-Road using the table SCC
onRoad_Source <- filter(SCC_ddply, grepl('On-Road', EI.Sector))

#Filter Baltimore City using above filter

Baltimore_Emission_on_Road <- NEI_ddply %>%
        filter(fips == "24510") %>%
        filter(SCC %in% coal$SCC) %>%
        group_by(year) %>%
        summarise(Total = sum(Emissions )) %>%
        select(Year = year, Emission = Total)
#plot

plot_Baltimore_on_Road <- qplot(Year, Emission, data = Baltimore_Emission_on_Road,
                       geom = "line") +
        ggtitle("Total Emission of PM2.5 in Baltimore City with motor vehicle sources = On-road") +
        xlab ("Years(s)") +
        ylab ("Total Emission (PM2.5)")

print(plot_Baltimore_on_Road)
dev.copy(png, file = "plot5.png")
dev.off()


