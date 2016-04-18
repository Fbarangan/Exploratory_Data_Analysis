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


# Plot 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

coal <- SCC_ddply %>%
        filter(grepl('Coal', Short.Name) | grepl('Coal', EI.Sector))


coal_NEI <- NEI_ddply %>%
        filter(SCC %in% coal$SCC) %>%
        group_by(year) %>%
        summarise(Total = sum(Emissions)) %>%
        select(Year = year, Emission = Total)

par(mar=c(5,5,4,2))
plot_coal_NEI <- qplot(Year, Emission, data = coal_NEI,
                       geom = "line") +
        ggtitle("Total Emission (PM2.5) in Baltimore City -Coal Combustion Source") +
        xlab ("Years(s)") +
        ylab ("Total Emission (PM2.5)")

print(plot_coal_NEI)
dev.copy(png, file = "plot4.png")
dev.off()
