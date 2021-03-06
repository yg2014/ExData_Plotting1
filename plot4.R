# Plot 4

## Read Data
con <- unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt")
data <- read.table(con, header=T, sep=";", na.strings = "?", stringsAsFactors = F)

### subset only the records of 1/2/2007 and 2/2/2007
data <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

### create n new column with date AND time combined
data$DateTime <- strptime(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")

### fix the class of Global_active_power
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)

data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

### Plot
layout(matrix(1:4, nrow = 2))

# p1
plot(data$DateTime, data$Global_active_power, type="l",ylab="Global Active Power",xlab="")

# p2
plot(data$DateTime, data$Sub_metering_1, type="l", ylab="Energy sub metering",xlab="")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

# create a legend 
legend("topright", legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = c(1,1,1), col = c("black","red","blue"), bty="n", xjust = 1, yjust = 0, 
       y.intersp = 0.8, x.intersp = 0.5, cex = 0.8)

# p3
plot(data$DateTime, data$Voltage, type="l", ylab="Voltage",xlab="datetine")

# p4
plot(data$DateTime,data$Global_reactive_power,type="l",
     ylab="Global_reactive_power",xlab="datetine")

dev.copy(png,"plot4.png",width=600,height=600)
dev.off()

