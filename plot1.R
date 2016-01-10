
# load dataset
ds<-read.table("household_power_consumption.txt",header = T, sep=';', na.strings = '?')

# fix Date column
ds$Date<-as.Date(ds$Date, format='%d/%m/%Y')

# keep only necessary data
ds<-ds[ds$Date=='2007-02-01' | ds$Date=='2007-02-02',]

# create datetime column
ds$datetime <- strptime(paste(ds$Date, as.character(ds$Time)),format="%Y-%m-%d %H:%M:%S")


#export chart to file
png("plot1.png",width=480,height=480,units="px")
with(ds,hist(Global_active_power,col="red",ylim=c(0,1300),xlab='Global Active Power (kilowatts)',main='Global Active Power'))
dev.off()