#Set working directory
#Load data
temp<- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
elec<- read.table(unz(temp, "household_power_consumption.txt"), sep= ";", 
                  header = TRUE, na.strings=c("NA", "-", "?"), stringsAsFactors = FALSE)
unlink(temp)

#Concatenate
elec$Date_time<- paste(elec$Date, elec$Time)
#Format Data
elec$Date_new<- as.Date(elec$Date, "%d/%m/%Y")
elec$Date_time<- strptime(elec$Date_time, "%d/%m/%Y %H:%M:%S")

#Filter based on dates
elec_date<- subset(elec, Date_new== "2007-02-01" | Date_new == "2007-02-02")
str(elec_date)

#Plot3
png(filename = "plot3.png", width = 480, height= 480 , bg= "transparent")
plot(elec_date$Date_time, elec_date$Sub_metering_1, type = "l", xlab = "",
     ylab= "Energy sub metering", col= "black")
lines(elec_date$Date_time, elec_date$Sub_metering_2, type = "l", xlab = "",
     ylab= "Energy sub metering", col= "red")
lines(elec_date$Date_time, elec_date$Sub_metering_3, type = "l", xlab = "",
      ylab= "Energy sub metering", col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, col= c("black", "red", "blue"))
dev.off()