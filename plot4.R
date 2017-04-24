##Loading and cleaning the data

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# format date to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#filter data set for assignment 
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# making sure rows have no missing values across the entire sequence

data <- data[complete.cases(data),]

#combining Date and Time column

DateTime <- paste(data$Date, data$Time)

#Name the vector

DateTime <- setNames(DateTime, "DateTime")

# Remove Date and Time column

data <- data[ ,!names(data) %in% c("Date","Time")]

#add DateTime column

data <- cbind(DateTime, data)

# Format DateTime column

data$DateTime <- as.POSIXct(DateTime)


## Generates Plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
     plot(Global_active_power ~ DateTime, type = "l", 
     ylab = "Global Active Power", xlab = "")
     plot(Voltage ~ DateTime, type = "l", ylab = "Voltage", xlab = "datetime")
     plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering",
          xlab = "")
     lines(Sub_metering_2 ~ DateTime, col = 'Red')
     lines(Sub_metering_3 ~ DateTime, col = 'Blue')
     legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
             bty = "n",
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power ~ DateTime, type = "l", 
          ylab = "Global_rective_power", xlab = "datetime")
})
dev.copy(png, "plot4.png", height=480, width=480)
dev.off()
