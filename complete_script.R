library(repmis)

gdp_global <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
edu <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

## clean global GDP data set
head(gdp_global)
### (1) subset df to new object, (2) remove top space, (3) only subset cols w/ data
clean_gdp <- subset(gdp_global[5:length(gdp_global$X),c(1,2,4,5)])
### rename the columns
colnames(clean_gdp)  <- c("country_code","rank","country","gdp_mmUSD")


## clean edu data set
head(edu)
### looks to be clean


## merge them on country code
merged_df <- merge(clean_gdp, edu, by.x = "country_code", by.y = "CountryCode")
### count the matches by checking length of country_code
length(merged_df$country_code)
### 224 country codes matched and merged


sorted <- merged_df[order(merged_df$gdp_mmUSD),]
sorted$gdp_mmUSD_F <- as.numeric(gsub("[^[:digit:]]","", sorted$gdp_mmUSD))


sorted$rank[(sorted$rank == "")] <- 0
sorted$rank <- as.numeric(sorted$rank)
aggregate(sorted$rank, list(sorted$Income.Group), mean, na.rm=TRUE, na.action=NULL)

library(ggplot2)



sorted$Income.Group[is.na(sorted$Income.Group)] <- "NA Group"

log_cut <- ggplot(sorted, aes(x=log(gdp_mmUSD_F), fill=Income.Group))
log_cut +  geom_density(alpha = 0.2) + xlim(0, 20)

norm_cut <- ggplot(sorted, aes(x=(gdp_mmUSD_F), fill=Income.Group))
norm_cut +  geom_density(alpha = 0.2) # defaults to stacking



quantile_df <- quantile_df[!is.na(quantile_df$rank),]
quantile_df <- quantiled_df[order(quantiled_df$gdp_mmUSD_F)]
end <- length(quantile_df$rank)
largest_38 <- quantile_df[(end-38):end,]
large_lwi <- largest_38[largest_38$Income.Group == "Lower middle income", ]


