library(dplyr)

# Step 1 - Download the zip file
filenameandpath = ".\\data\\power_consumption.zip"
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,filenameandpath,method="curl")

# Step 2 - Read the data from the zip file, extract out the date range that we want, and then save the data for that date range
# We will use that data to create all the plots
data <- read.table(unz(filenameandpath,"household_power_consumption.txt"), sep=";",header=TRUE)
data <- mutate(data, internal_date = as.POSIXct(Date,format="%d/%m/%Y"))
feb_data <- subset(data,internal_date >= '2007-02-01' & internal_date <= '2007-02-02')
rm("data")

# Step 3 - Optional - If intending to re-run this, then write the data onto disk to re-use in the future.
write.table(feb_data,".\\data\\feb_2007_1_2_power_consumption.txt",sep="\t",row.names=FALSE)

# Step 4 - Optional - If we are re-running this, then read the data from disk instead of downloading and re-subsetting etc. every time.
feb_data <- read.table(".\\data\\feb_2007_1_2_power_consumption.txt",sep="\t",header=TRUE)

# Step 5 - Actually produce the plot here
png(filename = "plot1.png")
hist(feb_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
