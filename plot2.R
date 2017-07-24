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

#Plot2
png(filename = "plot2.png", width = 480, height= 480 , bg= "transparent")
plot(elec_date$Date_time, elec_date$Global_active_power, type = "l", xlab = "",
     ylab= "Global Active Power (kilowatts)")
dev.off()