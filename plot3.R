
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
png(filename="plot3.png",width=480,height=480)
plot(household$Date,household$Sub_metering_1,type="l",xlab = "",ylab = "Energy sub metering")
lines(household$Date,household$Sub_metering_2,col="red")
lines(household$Date,household$Sub_metering_3,col="blue")
legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()