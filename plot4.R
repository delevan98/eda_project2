library(dplyr)
library(grDevices)
library(ggplot2)

#Forcibly remove scientifc notation
options(scipen = 999)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

combined_df <- merge(NEI, SCC, by="SCC")

coaldf  <- grepl("coal", combined_df$Short.Name, ignore.case=TRUE)

coalSubset <- combined_df[coaldf,]

coalDone <- coalSubset %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

png(filename="plot4.png")

p <- ggplot(coalDone, aes(x=year,y=Emissions, fill=year)) +
  geom_bar(stat="identity") +
  xlab("Year") +
  ylab("Total Emissions (tons)") +
  ggtitle("Total PM2.5 Emissions from Coal by Year") +
  scale_fill_manual(values=c("dodgerblue4", "dodgerblue3", "dodgerblue2", "dodgerblue1")) +
  theme(legend.position = "none")

print(p)
dev.off()
