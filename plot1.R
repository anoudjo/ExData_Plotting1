temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
datafile <- unzip(temp)
unlink(temp)
newdata <- read.table(datafile, header=TRUE, sep=";", stringsAsFactor=F,na.strings="?")
newdata$Date <- as.Date(newdata$Date, format="%d/%m/%Y")
#subdata <- newdata[(newdata$Date=="2007-02-01")|(newdata$Date=="2007-02-02"),]
subdata <- subset(newdata,subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(datafile)
rm(newdata)

globalActivePower <- as.numeric(subdata$Global_active_power)
#png("plot1.png", width = 480, height = 480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (Kilowatts)", ylab="Frequency") 
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
