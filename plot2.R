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

#draw the graph
plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, "plot2.png", width=480, height=480)

dev.off()