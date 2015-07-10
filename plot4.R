library(lubridate)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
unzip("household_power_consumption.zip")
mydata <- read.csv("household_power_consumption.txt", sep=";", na.strings='?', colClasses=c(rep('character', 2), 
                                                                                            rep('numeric', 7)))

file.remove("household_power_consumption.txt")
file.remove("household_power_consumption.zip")

mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")
mydata <- subset(mydata, Date >= as.Date('01/02/2007', "%d/%m/%Y") & Date <= as.Date('02/02/2007', "%d/%m/%Y"))
mydata$Date_Time <- ymd(mydata$Date) + hms(mydata$Time) 

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

with(mydata, {
  plot(Global_active_power ~ Date_Time, ylab='Global Active Power', xlab='', type="l")
  plot(Voltage ~ Date_Time, ylab='Voltage', xlab='datetime', type="l")
  plot_colors <- c("black", "red", "blue")
  plot(Sub_metering_1 ~ Date_Time, type="l", col=plot_colors[1], xlab="", ylab="Energy sub metering")
  lines(Sub_metering_2 ~ Date_Time, type="l", col=plot_colors[2])
  lines(Sub_metering_3 ~ Date_Time, type="l", col=plot_colors[3])
  legend("topright", c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=plot_colors, lwd=2, bty="n")
  plot(Global_reactive_power ~ Date_Time, xlab='datetime', type="l")
})
dev.off()

