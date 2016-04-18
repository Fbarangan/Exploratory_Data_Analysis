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

# Plot 1
# Summary of data per year, group by year, then summarize total of emmision by year using dplyr pipeline.
table(NEI_ddply$year)

EmissionsByYear <- NEI_ddply %>%
        group_by(year) %>%
        summarise(Total = sum(Emissions )) %>%
        select(Year = year, Emission = Total)

# Convert to log of 10 for better visualization
EmissionsByYear$Emission <- log10(EmissionsByYear$Emission)

par(mar=c(5,5,4,2))
#Plot using Base
plot1 <- plot(EmissionsByYear$Year, EmissionsByYear$Emission,
        xlab= "Year",
        ylab = "Total Emission by Year",
        main = "Total Emission (PM2.5) from 2000 to 2008",
        pch = 10)

print(plot1)
dev.copy(png, file = "plot1.png")
dev.off()
