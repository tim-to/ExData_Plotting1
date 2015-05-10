
inFile<-"household_power_consumption.txt"

# Read in the file. The line number to skip been determine by first looking in the
# data file and searching for the start date of 1/2/2007
household<-read.table(inFile, sep=";", header=F, skip=66637, nrow=2880, stringsAsFactors=F)
# Set the column names by reading the first line then copy over the column names.
dataname<-read.table(inFile, sep=";", header=T,  nrow=1)
colnames(household) <-colnames(dataname)
# Combine the date and time columns to form the complete date.
household$Date <-strptime(paste(household$Date, household$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# plot the data to a png device
png(filename="plot4.png",width=480,height=480)
# set the multipanel to 2 x 2 grid and give the left side margin more space to display y axis lables
par(mfrow =c(2,2), oma=c(0,1,0,0))
with(household, {
  #base plot #1 Global Active power
  plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Power")
  #base plot #2 Voltage
  plot(Date, Voltage, type="l", xlab="datetime", ylab="Voltage")
  #base plot #3 Energy sub metering 
  plot(Date,Sub_metering_1,type="l",xlab = "",ylab = "Energy sub metering")
    lines(Date,Sub_metering_2,col="red")
    lines(Date,Sub_metering_3,col="blue")
    legend("topright", lwd=1, pch=NA, col = c("black", "red", "blue"), bty="n",
           legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  #base plot #4 Global reactive power
  plot(Date, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()
