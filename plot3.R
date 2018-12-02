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
#convert date to date format
df_step1$Date <- as.Date(df_step1$Date, format="%d/%m/%Y")
df_step1$Global_active_power <- as.numeric(df_step1$Global_active_power)
df_step1$datetime <- as.POSIXct(paste(df_step1$Date, df_step1$Time))

# Prevents Scientific Notation
#df_step1[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#export
png("plot3.png", width=480, height=480)

#plot
with(df_step1, {
        plot(Sub_metering_1~datetime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~datetime,col='Red')
        lines(Sub_metering_3~datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
