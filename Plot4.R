NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_SCC <- merge(NEI, SCC, by="SCC")

library(ggplot2)

coalMatches  <- grepl("coal", NEI_SCC$Short.Name, ignore.case=TRUE)
subset_NEISCC <- NEISCC[coalMatches, ]

TotalEmissions_ByYear <- aggregate(Emissions ~ year, subset_NEISCC, sum)



png("plot4.png", width=640, height=480)
g <- ggplot(TotalEmissions_ByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()