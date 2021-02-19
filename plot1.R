library(dplyr)
library(grDevices)

#Forcibly remove scientifc notation
options(scipen = 999)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totaldf <- NEI %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

png(filename="plot1.png")

with(totaldf, barplot(Emissions, col=c("indianred4", "lightskyblue3", "seagreen3", "burlywood3"), main="Total Emissions of PM2.5 in the U.S.",
     xlab="Year", ylab="Total Emissions (tons)", names.arg = year))

dev.off()

