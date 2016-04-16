# Plot 2 Exploratory Data Analysis (Global Active Power vs datetime)
# Author: Carlos Gutiérrez
# The code does the following:
# 1- creates a new directory
# 2- downloads the data from the UC Irvine Machine Learning Repository: "Individual household electric power consumption Data Set"
# 3- unzips the file and reads the data, formatting dates and times (creating a new "datetime" field)
# 4- plots the Global Active Power (kW) between 2007-02-01 and 2007-02-02, and saves the plot as a PNG file


# Create a new directory and download the data file
if(!file.exists("ExData_Plotting1")) {
  dir.create("ExData_Plotting1")
}
setwd("ExData_Plotting1")
myUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(myUrl,destfile = "data.zip",method="curl")

# Unzip the data
unzip("data.zip")

# Read the data (separator is ";" and "?" is NA)
consumption_data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

# Convert Dates,create a new datetime column and subset between 2007-02-01 and 2007-02-02
consumption_data$Date<-as.Date(consumption_data$Date,"%d/%m/%Y")
consumption_data$datetime <- with(consumption_data, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))
consfeb07<-subset(consumption_data,Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))


# Plot the data (line plot of Global Active Power vs Time) and copy to PNG file (always close the device)
par(mfrow=c(1,1))
Sys.setlocale("LC_TIME", "English") # This is needed to get your axis in English for a non-English install
plot(consfeb07$datetime,consfeb07$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png,"Plot2.png")
dev.off()