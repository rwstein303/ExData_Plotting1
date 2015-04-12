## This script will produce the following plots in a 2x2 grid in plot4.png:
##
##      Global Active Power
##      Voltage
##      Energy sub metering
##      Global Reactive Power
##
## The data for these plots is located at the URL specfied below.  The file is
## filtered to use only data from Feb 1, 2007 and Feb 2, 2007.

## Download the data file and unzip it.
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="download.zip")
unzip("download.zip")

## Read the downloaded data.
HouseholdData <- read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

## Subset the data for the required dates.
PlotData <- subset(HouseholdData, as.Date(HouseholdData[,1], "%d/%m/%Y") == "2007-02-01" | as.Date(HouseholdData[,1], "%d/%m/%Y") == "2007-02-02")

## Add a column that combines the Data and Time columns.
PlotData$datetime <- as.POSIXct(strptime(paste(PlotData$Date,PlotData$Time),"%d/%m/%Y %H:%M:%S"))

## Open a .png file and create the plot.
png(file="plot4.png")
par(mfrow=c(2,2), pch=".")
with(PlotData, {
    plot(datetime, Global_active_power, xlab="", ylab="Global Active Power", lines(datetime,Global_active_power))
    plot(datetime, Voltage, lines(datetime, Voltage))
    plot(datetime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
        lines(PlotData$datetime, PlotData$Sub_metering_1)
        lines(PlotData$datetime, PlotData$Sub_metering_2, col="red")
        lines(PlotData$datetime, PlotData$Sub_metering_3, col="blue")
        legend("topright", pch="-", col=c("black", "red", "blue"), bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(datetime, Global_reactive_power, lines(datetime, Global_reactive_power))
})
dev.off()