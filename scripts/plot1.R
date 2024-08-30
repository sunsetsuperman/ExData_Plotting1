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

hist(exdataSubset$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.copy(png, "./plots/plot1.png")
dev.off()
