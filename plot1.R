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

### plot 1
hist(as.numeric(as.character(data$Global_active_power)),col="red",
     main="Global Active Power",xlab="Global Active Power(kilowatts)")