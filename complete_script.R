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

head(merged_df[merged_df$Income.Group == "High Income: OECD"])
