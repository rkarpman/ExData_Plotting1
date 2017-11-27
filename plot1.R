## Load and process the data
library(dplyr)
power_data <- read.table("household_power_consumption.txt", head = TRUE, sep = ";", na.strings = "?")
power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%Y")
power_sub <- filter(power_data, Date == as.Date("2007-02-01", format = "%Y-%m-%d") | Date == as.Date("2007-02-02", format = "%Y-%m-%d"))

## Create the plot
png(filename = "plot1.png")
hist(power_sub$Global_active_power, main = "", xlab = "", col = "red")
title(main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()