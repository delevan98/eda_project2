library(dplyr)
library(grDevices)
library(ggplot2)

#Forcibly remove scientifc notation
options(scipen = 999)

NEI <- readRDS("summarySCC_PM25.rds")
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

baltNRTotal <- NEI %>% subset(fips=="24510") %>% group_by(year, type) %>% summarise(Emissions=sum(Emissions))

png(filename="plot3.png")

p <- ggplot(baltNRTotal, aes(x=year,y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("Year") +
  ylab("Total Emissions (tons)") +
  ggtitle("Total PM2.5 Emissions in Baltimore by Year and Type") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  scale_fill_manual(values=c("darkgoldenrod3", "gray34", "palegreen4", "saddlebrown"))
print(p)
dev.off()
