
# need to st locale since I live in Brazil...
# otherwise it would appear "Qui Sex Sab" instead of "Thu Fri Sat"
Sys.setlocale("LC_TIME", "C")

# load dataset
ds<-read.table("household_power_consumption.txt",header = T, sep=';', na.strings = '?')

# fix Date column
ds$Date<-as.Date(ds$Date, format='%d/%m/%Y')

# keep only necessary data
ds<-ds[ds$Date=='2007-02-01' | ds$Date=='2007-02-02',]

# create datetime column
ds$datetime <- strptime(paste(ds$Date, as.character(ds$Time)),format="%Y-%m-%d %H:%M:%S")


#export chart to file
png("plot4.png",width=480,height=480,units="px")

# create 2x2 canvas
par(mfcol=c(2,2))


#plot chart1
plot(ds$datetime,ds$Global_active_power,type='l',ylab='Global Active Power (kilowatts)',xlab='')


#plot chart2
plot(ds$datetime,ds$Sub_metering_1,type='n',ylab='Energy sub metering',xlab='')
points(ds$datetime,ds$Sub_metering_1,type='l',col='black')
points(ds$datetime,ds$Sub_metering_2,type='l',col='red')
points(ds$datetime,ds$Sub_metering_3,type='l',col='blue')
legend("topright",pch='_',col=c("black","red","blue"),ncol=1,cex = 0.50,bty='n',legend=c(names(ds[,7:9])))


#plot chart3
plot(ds$datetime,ds$Voltage,type='l',ylab='Voltage',xlab='datetime')

#plot chart4
plot(ds$datetime,ds$Global_reactive_power,type='l',ylab='Global_reactive_power',xlab='datetime')

dev.off()
