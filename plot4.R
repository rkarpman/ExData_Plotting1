## Load and process the data
library(dplyr)
power_data <- read.table("household_power_consumption.txt", head = TRUE, sep = ";", na.strings = "?")
power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%Y")
power_sub <- filter(power_data, Date == as.Date("2007-02-01", format = "%Y-%m-%d") | Date == as.Date("2007-02-02", format = "%Y-%m-%d"))
power_sub <- mutate(power_sub, DateTime = as.POSIXct(strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")))

## Create the plot
png(filename = "plot4.png")
par(mfcol = c(2, 2))
## First subplot
with(power_sub, plot(DateTime, Global_active_power, main = "", xlab = "", ylab = "", type = "l"))
title(ylab = "Global Active Power")

## Second subplot
with(power_sub, {
    plot(DateTime, Sub_metering_1, main = "", xlab = "", ylab = "", type = "l")
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"), lty = 1)
    title(ylab = "Energy sub metering")})

## Third subplot
with(power_sub, 
    plot(DateTime, Voltage, main = "", xlab = "datetime", ylab = "Voltage", type = "l"))

## Fourth subplot
with(power_sub, 
    plot(DateTime, Global_reactive_power, main = "", xlab = "datetime", ylab = "Global_reactive_power", type = "l")
)
dev.off()