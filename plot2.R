# Plot 2

## Read Data
con <- unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt")
data <- read.table(con, header=T, sep=";", na.strings = "?", stringsAsFactors = F)

### subset only the records of 1/2/2007 and 2/2/2007
data <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

### create n new column with date AND time combined
data$DateTime <- strptime(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")

### fix the class of Global_active_power
data$Global_active_power <- as.numeric(data$Global_active_power)

### Plot
plot(data$DateTime,data$Global_active_power,type="l",
     ylab="Global Active Power (kilowatts)",xlab="")

dev.copy(png,"plot2.png",width=504,height=504)
dev.off()

