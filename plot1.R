## This script will produce a histogram of Global Active Power from the data
## located at the URL specfied below.  The file is filtered to use only data
## from Feb 1, 2007 and Feb 2, 2007.  The resulting histogram will be stored
## in plot1.png for viewing.

## Download the data file and unzip it.
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="download.zip")
unzip("download.zip")

## Read the downloaded data.
HouseholdData <- read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

## Subset the data for the required dates.
PlotData <- subset(HouseholdData, as.Date(HouseholdData[,1], "%d/%m/%Y") == "2007-02-01" | as.Date(HouseholdData[,1], "%d/%m/%Y") == "2007-02-02")

## Open a .png file and create the histogram.
png(file="plot1.png")
hist(PlotData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()