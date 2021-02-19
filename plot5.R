library(dplyr)
library(grDevices)
library(ggplot2)

#Forcibly remove scientifc notation
options(scipen = 999)

NEI <- readRDS("summarySCC_PM25.rds")
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

baltdf <- NEI %>% subset(fips=="24510" & type=="ON-ROAD") %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

png(filename="plot5.png")
p <- ggplot(baltdf, aes(x=year,y=Emissions, fill=year)) +
  geom_bar(stat="identity") +
  xlab("Year") +
  ylab("Total Emissions (tons)") +
  ggtitle("Total PM2.5 Emissions from Motor Vehicles in Baltimore City (1999-2008)") +
  scale_fill_manual(values=c("firebrick4", "firebrick3", "firebrick2", "firebrick1")) +
  theme(legend.position = "none")

print(p)
dev.off()
