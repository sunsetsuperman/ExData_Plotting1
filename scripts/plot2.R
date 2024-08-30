if(!file.exists("./data")) {dir.create("./data")}
if(!file.exists("./data/exdata.zip")) {
      fileName <- "./data/exdata.zip"
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, destfile = fileName, method = "curl")}
if(!file.exists("./data/household_power_consumption.txt")) {
      unzip("./data/exdata.zip", exdir = "./data")}

exdata <- read.table("./data/household_power_consumption.txt",
                     sep = ";", na.strings = "?", header = T, stringsAsFactors = F)

exdataSubset <- subset(exdata, exdata$Date == "1/2/2007" | exdata$Date == "2/2/2007")
exdataSubset$Date <- as.Date(exdataSubset$Date, "%d/%m/%Y")
exdataSubset$Time <- strptime(paste(exdataSubset$Date, exdataSubset$Time),
                              format="%Y-%m-%d %H:%M:%S")

plot(exdataSubset$Time, exdataSubset$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     xaxt = "n")

dates <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
labels <- c("Thu", "Fri", "Sat")
axis(1, at = dates, labels = labels, las = 1)

dev.copy(png, "./plots/plot2.png")
dev.off()
