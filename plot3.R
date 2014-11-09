LoadAndCleanData <- function() {
    #Load data into memory
    dat <- read.table("household_power_consumption.txt",
                      sep=";", header=T, na.strings=c("?"))
    
    #Append datetime field based on Date and Time fields
    dat$datetime <- strptime(paste(dat$Date, dat$Time),
                             format="%d/%m/%Y%H:%M:%S")
    
    #Reduce dataset to dates of interest
    dat <- subset(dat, as.Date(datetime) >= as.Date("2007-02-01"))
    dat <- subset(dat, as.Date(datetime) <= as.Date("2007-02-02"))
    
    dat
}

producePlot3 <- function(dat) {
    yAxisText <- "Energy sub metering"
    
    with(dat, {
        plot(datetime, Sub_metering_1, xlab="", ylab=yAxisText, type="n")
        lines(datetime, Sub_metering_1)
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
        
        cols = c("black", "red", "blue")
        legends = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        legend("topright", col = cols, lty=1, legend = legends)
    }) 
}

#Run script.
#First produce clean data, then produce plot.
dat <- LoadAndCleanData()
producePlot3(dat)

