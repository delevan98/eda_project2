library(dplyr)
library(grDevices)

#Forcibly remove scientifc notation
options(scipen = 999)

NEI <- readRDS("summarySCC_PM25.rds")

baltSub <- subset(NEI, fips == "24510")

baltTotal <- baltSub %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

png(filename="plot2.png")

with(baltTotal, barplot(Emissions, col=c("orangered", "floralwhite", "black", "gray54"), main="Total Emissions of PM2.5 in Baltimore",
                      xlab="Year", ylab="Total Emissions (tons)", names.arg = year))

dev.off()
