## Loading required libraries
library(dplyr)

## Loading data into R session
if (!file.exists("./data")) 
{
    dir.create("./data")
}

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/exdata_household_power_consumption.zip")

dataset <- read.csv(unz("./data/exdata_household_power_consumption.zip", "household_power_consumption.txt"), sep = ';', header = TRUE, quote = "", na.strings = "?", stringsAsFactors = FALSE)

dataset <- tbl_df(dataset)

dataset <- dataset %>% mutate(Date = as.Date(dataset$Date, format = "%d/%m/%Y")) %>% filter(Date >= '2007-2-1' & Date <= '2007-2-2') %>% mutate(DateTime = as.POSIXct(strptime(paste(Date, Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")))

## Histogram of Global Active Power
png(file = "./data/plot1.png", width = 480, height = 480)
hist(dataset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
