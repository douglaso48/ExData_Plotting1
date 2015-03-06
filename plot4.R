#setwd("~/R/eda")
library(dplyr)

#This script assumes that the data has been downloaded an unzipped into the working directory.
#Read the data
power<- read.csv("~/R/eda/exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

#convert to local data frame
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
df$Voltage<- as.numeric(df$Voltage)
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)


#generate and write the plot, set parameters and labels
png(file="plot4.png", width = 480, height = 480, units = "px")

par(mfcol=c(2,2),  mar=c(5.1,4,4,2), font.axis=2, font.lab=2)
    
plot(df$daytime, df$Global_active_power, type="l", xlab="", ylab= "Global Active Power")

plot(df$daytime,df$Sub_metering_1, type="l", lty=1,xlab="", ylab= "Energy sub metering")
lines(df$daytime, df$Sub_metering_2, type="l", lty=1,col="red")
lines(df$daytime, df$Sub_metering_3, type="l", lty=1, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",lty=c(1,1,1),col=c("black","red","blue"))

plot(df$daytime, df$Voltage, xlab= "datetime", ylab= "Voltage",type="l")

plot(df$daytime, df$Global_reactive_power, type="l",xlab= "datetime", ylab= "Global_reactive_power")

dev.off()