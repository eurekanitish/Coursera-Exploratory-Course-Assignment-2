NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

NEI_SCC <- merge(NEI, SCC, by="SCC")
library(ggplot2)

subset_NEI <- NEI[NEI$fips=="24510"|NEI$fips=="06037" & NEI$type=="ON-ROAD",  ]

Total_Emissions_ByYearAndFips <- aggregate(Emissions ~ year + fips, subset_NEI, sum)
Total_Emissions_ByYearAndFips$fips[Total_Emissions_ByYearAndFips$fips=="24510"] <- "Baltimore, MD"
Total_Emissions_ByYearAndFips$fips[Total_Emissions_ByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(Total_Emissions_ByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()