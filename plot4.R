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

#Plot4
png(filename = "plot4.png", width = 480, height= 480 , bg= "transparent")
par(mfrow= c(2,2))
#First plot
        plot(elec_date$Date_time, elec_date$Global_active_power, type = "l", xlab = "",
        ylab= "Global Active Power")
#Second plot
        plot(elec_date$Date_time, elec_date$Voltage, type = "l", xlab = "datetime",
        ylab= "Voltage")
#Third plot
        plot(elec_date$Date_time, elec_date$Sub_metering_1, type = "l", xlab = "",
                ylab= "Energy sub metering", col= "black")
        lines(elec_date$Date_time, elec_date$Sub_metering_2, type = "l", xlab = "",
                ylab= "Energy sub metering", col= "red")
        lines(elec_date$Date_time, elec_date$Sub_metering_3, type = "l", xlab = "",
                ylab= "Energy sub metering", col= "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                lty=1, col= c("black", "red", "blue"), inset = 0.01,cex= 0.9, box.lty = 0)
#Fourth plot
        plot(elec_date$Date_time, elec_date$Global_reactive_power, type = "l", xlab = "datetime",
             ylab= "Global_reactive_power")
        
dev.off()