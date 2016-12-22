NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subset_NEI  <- NEI[NEI$fips=="24510", ]

Total_Emissions_byYear <- aggregate(Emissions ~ year, subset_NEI, sum)

png('plot2.png')
barplot(height=Total_Emissions_byYear$Emissions, names.arg=Total_Emissions_byYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
dev.off()