## This code assumes that the working directory contains the data file 'household_power_consumption.txt' 
## and then saves the plot in the same directory. 

# Check if hpc_ss (the subsetted data) already exists (i.e., has this source been run recently.) 
# To be sure your using the right data, call rm(hpc_ss) before first use
if ( !exists( "hpc_ss" ) ) {
	# Read in the data
	hpc_all <- read.table("household_power_consumption.txt",
						 sep =";", 
						 nrows = 2.1e6, 
						 header = TRUE, 
						 na.strings = "?", 
						 colClasses = c("character",
						 				"character", 
						 				"numeric", 
						 				"numeric", 
						 				"numeric", 
						 				"numeric", 
						 				"numeric", 
						 				"numeric", 
						 				"numeric")
						 )
						 
	# Convert the Date and Time in the first to variables from chr to POSIXlt class and store in new variable
	hpc_all$DateTime <- strptime(paste(hpc_all$Date, hpc_all$Time), format = "%d/%m/%Y %H:%M:%S")
	
	# Subset the rows of data we actually need, i.e. 2-1 to 2-2 in 2007
	hpc_ss <- subset(hpc_all, hpc_all$DateTime >= "2007-02-01" & hpc_all$DateTime < "2007-02-03")
}

# Open a png device, draw the plot, and save the file
png("plot3.png")
plot(hpc_ss$DateTime, hpc_ss$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(hpc_ss$DateTime, hpc_ss$Sub_metering_1, col = "black")
lines(hpc_ss$DateTime, hpc_ss$Sub_metering_2, col = "red")
lines(hpc_ss$DateTime, hpc_ss$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1))
dev.off()