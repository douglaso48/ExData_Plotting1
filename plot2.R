#setwd("~/R/eda")
library(dplyr)

#This script assumes that the data has been downloaded an unzipped into the working directory.
#Read the data

power<- read.csv("exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

#set as local data frame
power<- tbl_df(power)

#set the Date values to as.Date to allow correct subsetting
power$Date<- as.Date(power$Date, "%d/%m/%Y")

#subset to the required date range
df<- filter(power, Date=="2007/02/01" | Date=="2007/02/02")

#set Date & Time to POSIX
df$daytime<- paste(df$Date, df$Time)
df$daytime<- as.POSIXct(df$daytime)

#set the values to numeric to allow correct handling of data
df$Global_active_power<-as.numeric(df$Global_active_power)

#generate and write the plot, set parameters and labels
png(file="plot2.png", width = 480, height = 480, units = "px")

plot(df$daytime,df$Global_active_power, type="l", xlab="", ylab= "Global Active Power (kilowatts)")

dev.off()
