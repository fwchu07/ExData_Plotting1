#Plot 2

#if energy does not exist, download and clean dataset

if ((exists('energy') && is.data.frame(get('energy')))==FALSE) {
  myURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(myURL,temp)
  dat <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header=TRUE)
  
  #change date and time formats, change character to numeric
  dat$Date <- as.Date(strptime(dat$Date,'%d/%m/%Y'),'%Y/%m/%d')
  
  #Subset data for only 2 dates
  dat2 <- subset(dat,Date == "2007-02-01" | Date == "2007-02-02")
  
  #review dataset and make changes to type
  str(dat2)
  
  dat2$Global_active_power <- as.numeric(dat2$Global_active_power)
  dat2$Global_reactive_power <- as.numeric(dat2$Global_reactive_power)
  dat2$Voltage <- as.numeric(dat2$Voltage)
  dat2$Global_intensity <- as.numeric(dat2$Global_intensity)
  dat2$Sub_metering_1 <- as.numeric(dat2$Sub_metering_1)
  dat2$Sub_metering_2 <- as.numeric(dat2$Sub_metering_2)
  
  #add variable to combine date and time
  dat2$datetime <- as.POSIXct(paste(dat2$Date, dat2$Time), format="%Y-%m-%d %H:%M:%S")
  
  #copy final dataset to be used
  energy <-dat2
}

#Create plot and save as png
png("plot2.png")

plot(energy$datetime,energy$Global_active_power,typ="l", xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()