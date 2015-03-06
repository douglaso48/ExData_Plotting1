#setwd("~/R/eda")
library(dplyr)

#This script assumes that the data has been downloaded an unzipped into the working directory.
#Read the data
power <- read.csv("exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

#set as local data frame
power<- tbl_df(power)

#set the Date values to as.Date to allow correct subsetting
power$Date<- as.Date(power$Date, "%d/%m/%Y")

#subset to the required date range
df<- filter(power, Date=="2007/02/01" | Date=="2007/02/02")

#set the values to numeric to allow correct handling of data
df$Global_active_power<-as.numeric(df$Global_active_power)

#create and write the plot
png(file="plot1.png", width = 480, height = 480, units = "px")

plot1<-hist(df$Global_active_power, xlab= "Global Active Power (kilowatts)",ylab="Frequency", col="red", main="Global Active Power")

dev.off()
