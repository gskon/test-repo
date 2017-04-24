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


with(data, { plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy Sub metering", xlab = "")
    lines(Sub_metering_2 ~ DateTime, col = 'Red')
    lines(Sub_metering_3 ~ DateTime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, "plot3.png", height=480, width=480)
dev.off()
