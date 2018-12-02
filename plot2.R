#read data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".", na.strings="?")

#check if current memory is enough to read data
# total rows * total columns * 8 (bytes) / 2^20 (in MB)
t_row <- nrow(df)
t_col <- ncol(df)
req_memory <- (t_row * t_col * 8) / 2^20
req_memory

#subset data
df_step1 <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]

#convert data format
datetime <- strptime(paste(df_step1$Date, df_step1$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(df_step1$Global_active_power)

# Prevents Scientific Notation
#df_step1[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#export
png("plot2.png", width=480, height=480)

#plot
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
