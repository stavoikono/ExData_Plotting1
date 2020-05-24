library(dplyr)

### downloading the dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp,mode="wb")
unzip(temp, "household_power_consumption.txt")
unlink(temp)

### loading the dataset
df <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = T)
### Creating a new column with complete date time
df <- df %>% mutate(datetime=as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))
### Changing the format of Date column to be as date
df$Date <- as.Date(df$Date,tryFormats = c("%d/%m/%Y"))
### Filtering the days we want to work
data <- df %>% filter(Date=="2007-02-01"| Date=="2007-02-02")

### Plot 4
par(mfrow=c(2,2))

with(data,{
  plot(data$datetime,as.numeric(as.character(data$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(data$datetime,as.numeric(as.character(data$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(data$datetime,data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(data,lines(datetime,as.numeric(as.character(Sub_metering_1))))
  with(data,lines(datetime,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(data,lines(datetime,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(data$datetime,as.numeric(as.character(data$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})