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
subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1))
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))
subdata$Sub_metering_3 <- as.numeric(as.character(subdata$Sub_metering_3))
# png("plot3.png", width = 480, height = 480)

plot(subdata$Datetime, subdata$Sub_metering_1, type ="l",xlab = "", ylab = "Energy Submetering")
lines(subdata$Datetime, subdata$Sub_metering_2, type = "l", col = "red")
lines(subdata$Datetime, subdata$Sub_metering_3, type = "l", col = "blue")

legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), 
       lty = 1, lwd = 2.5, col = c("black","blue","red"))
dev.copy(png, file = "plot3.png")
dev.off()