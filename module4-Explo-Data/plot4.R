## Plot4

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "data.zip")
unzip("data.zip", "household_power_consumption.txt")
data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subdata <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$Datetime <- as.POSIXct(datetime)
par(mfrow=c(2,2), mar=c(4,4,2,3), oma=c(0,1,0,0))
with(subdata, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l",
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l",
       ylab="Global_rective_power",xlab="datetime")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
