## This script will produce a line plot of Global Active Power from the data
## located at the URL specfied below.  The file is filtered to use only data
## from Feb 1, 2007 and Feb 2, 2007.  The resulting line plot will be stored
## in plot2.png for viewing.

## Download the data file and unzip it.
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="download.zip")
unzip("download.zip")

## Read the downloaded data.
HouseholdData <- read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

## Subset the data for the required dates.
PlotData <- subset(HouseholdData, as.Date(HouseholdData[,1], "%d/%m/%Y") == "2007-02-01" | as.Date(HouseholdData[,1], "%d/%m/%Y") == "2007-02-02")

## Add a column that combines the Data and Time columns.
PlotData$DateTime <- as.POSIXct(strptime(paste(PlotData$Date,PlotData$Time),"%d/%m/%Y %H:%M:%S"))

## Open a .png file and create the plot.
png(file="plot2.png")
par(pch=".")
with(PlotData, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()