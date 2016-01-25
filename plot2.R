temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
datafile <- unzip(temp)
unlink(temp)
newdata <- read.table(datafile, header=TRUE, sep=";", stringsAsFactor=F,na.strings="?")
newdata$Date <- as.Date(newdata$Date, format="%d/%m/%Y")

subdata <- subset(newdata,subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(datafile)

datetime <- paste(subdata$Date, subdata$Time, sep = " ")
#datetime <- strptime(paste(subdata$Date, subdata$Time, sep = " "),"%d/%m/%Y %H:%M:%S")
subdata$Datetime <- as.POSIXct(datetime)



globalActivePower <- as.numeric(subdata$Global_active_power)

plot(subdata$Datetime, globalActivePower, type ="l",xlab = "", ylab = "Global Active Power (Kilowatts)") 
dev.copy(png, file = "plot2.png")
dev.off()
rm(newdata)