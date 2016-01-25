temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
datafile <- unzip(temp)
unlink(temp)
newdata <- read.table(datafile, header=TRUE, sep=";", stringsAsFactor=F,na.strings="?")
newdata$Date <- as.Date(newdata$Date, format="%d/%m/%Y")

subdata <- subset(newdata,subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(datafile)
rm(newdata)

datetime <- paste(subdata$Date, subdata$Time, sep = " ")

subdata$Datetime <- as.POSIXct(datetime)

globalActivePower <- as.numeric(subdata$Global_active_power)
globalReactivePower <- as.numeric(subdata$Global_reactive_power)
voltage <- as.numeric(subdata$Voltage)
subdata$Sub_metering_1 <- as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2 <- as.numeric(subdata$Sub_metering_2)
subdata$Sub_metering_3 <- as.numeric(subdata$Sub_metering_3)


par(mfrow = c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(subdata$Datetime, globalActivePower, type = "l", asp = 1, xlab = "", ylab = "Global Active Power")

plot(subdata$Datetime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(subdata$Datetime, subdata$Sub_metering_1, type ="l",xlab = "", ylab = "Energy Submetering")
lines(subdata$Datetime, subdata$Sub_metering_2, type = "l", col = "red")
lines(subdata$Datetime, subdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), 
       lty = 1, lwd = 2.5, col = c("black","blue","red"))

plot(subdata$Datetime, globalReactivePower, type = "l", xlab = "", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png")
dev.off()
