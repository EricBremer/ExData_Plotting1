#retreive data and store it in a "data" subdirectory of the working directory 

if(!file.exists("data")) {dir.create("data")} #creates "data" subdirectory if it does not already exist
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" #Url of data to download
download.file(fileURL, destfile="./data/household_power_consumption.zip", method="curl")
## read data
colclasses = c("character", "character", rep("numeric",7))
data <- read.table(unzip("./data/household_power_consumption.zip"), header=TRUE, colClasses = colclasses, na.strings="?", sep=";")

# Paste the date and time fields onto each other and into a new field called DateTime
data <- within(data, DateTime <- paste(Date, Time, sep=" "))

# Convert DateTime (character) to a real Date class format
data$DateTime = as.POSIXct(strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")) 

#Subset data to retreive data from the dates to be used for plotting
PlotData = subset(data, DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03"))


##Create histogram of "Global Active Power" in png graphics format(plot1.png)

if(!file.exists("figures")) {dir.create("figures")} #creates "figures" subdirectory if it does not already exist
png("./figures/plot1.png", height=480, width=480)#opens png graphics device in the "figures" subdirectory of the working directory
#create histogram
hist(PlotData$Global_active_power,
     col='red',
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power')
dev.off() #closes png graphic device

               
               