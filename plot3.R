## read data
colclasses = c("character", "character", rep("numeric",7))
data <- read.table("./data/household_power_consumption.txt", header=TRUE, colClasses = colclasses, na.strings="?", sep=";")

# Paste the date and time fields onto each other and into a new field called DateTime
data <- within(data, DateTime <- paste(Date, Time, sep=" "))

# Convert DateTime (character) to a real Date class format
data$DateTime = as.POSIXct(strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")) 

#Subset data to retreive data from the dates to be used for plotting
PlotData = subset(data, DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03"))

if(!file.exists("figures")) {dir.create("figures")} #creates "figures" subdirectory if it does not already exist
png("./figures/plot3.png", height=480, width=480)#opens png graphics device in the "figures" subdirectory of the working directory
plot(x=(PlotData$DateTime),y=PlotData$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(x=(PlotData$DateTime),y=PlotData$Sub_metering_2,col="red")
lines(x=(PlotData$DateTime),y=PlotData$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="l",col=c("black","red","blue"),lwd=2)
dev.off() #closes png graphic device
