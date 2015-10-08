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
    
    return(dat)
}

producePlot4 <- function(dat) {
    png(file="plot4.png", width = 480, height = 480)
    #Produce 2 by 2 plot, using single plots where possible
    par(mfrow = c(2,2), oma=c(2,0,0,0))
    
    #top-left plot
    yAxisText <- "Global Active Power (kilowatts)"
    
    with(dat, {
        plot(datetime, Global_active_power, xlab="", ylab=yAxisText, type="n")
        lines(datetime, Global_active_power)
    })
    
    #top-right plot
    with(dat, plot(datetime, Voltage, type="l"))
    
    #bottom-left plot
    yAxisText <- "Energy sub metering"
    
    with(dat, {
        plot(datetime, Sub_metering_1, xlab="", ylab=yAxisText, type="n")
        lines(datetime, Sub_metering_1)
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
    })
    
    cols = c("black", "red", "blue")
    legends = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    legend("topright", col = cols, lty=1, lwd=2, bty="n", legend = legends)
    
    #bottom-right plot
    with(dat, plot(datetime, Global_reactive_power, type="l"))
    dev.off()
}

#Run script.
#First produce clean data, then produce plot.
dat <- LoadAndCleanData()
producePlot4(dat)
