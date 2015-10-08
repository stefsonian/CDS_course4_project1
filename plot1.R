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

producePlot1 <- function(dat) {
    png(file="plot1.png", width = 480, height = 480)
    titleText <- "Global Active Power"
    xAxisText <- "Global Active Power (kilowatts)"
    
    with(dat, hist(Global_active_power, col="red",
                   main=titleText, xlab=xAxisText))
    dev.off()
}

#Run script.
#First produce clean data, then produce plot.
dat <- LoadAndCleanData()
producePlot1(dat)