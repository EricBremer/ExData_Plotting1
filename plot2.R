## read data
colclasses = c("character", "character", rep("numeric",7))
data <- read.table("./data/household_power_consumption.txt", header=TRUE, colClasses = colclasses, na.strings="?", sep=";")

# Paste the date and time fields onto each other and into a new field called DateTime
data <- within(data, DateTime <- paste(Date, Time, sep=" "))

# Convert DateTime (character) to a real Date class format
data$DateTime = as.POSIXct(strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")) 

#Subset data to retreive data from the dates to be used for plotting
PlotData = subset(data, DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03"))


##Plot of Global Active Pover in kilowatts for the date range(plot2.png)

if(!file.exists("figures")) {dir.create("figures")} #creates "figures" subdirectory if it does not already exist
png("./figures/plot2.png", height=480, width=480)#opens png graphics device in the "figures" subdirectory of the working directory
plot(x=(PlotData$DateTime),y=PlotData$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off() #closes png graphic device
