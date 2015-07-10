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

png(filename = "plot2.png", width = 480, height = 480)
plot(Global_active_power ~ Date_Time, mydata, ylab='Global Active Power (kilowatts)', xlab='', type="l")
dev.off()