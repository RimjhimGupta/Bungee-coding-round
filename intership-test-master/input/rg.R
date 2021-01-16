library(data.table)
library(stringr)
# data frames
library(dplyr)

# Reading the files
main <- fread("E:/Program Files/R/R-4.0.3/intership-test-master/input/main.csv")
# View(main)        
filteredCountry <- main[like(COUNTRY,'USA')]
# View(filteredCountry)
print(nrow(main))
print(nrow(filteredCountry ))
fwrite(filteredCountry, "E:/Program Files/R/R-4.0.3/intership-test-master/output/filteredCountry.csv")

filteredCountry <- fread("E:/Program Files/R/R-4.0.3/intership-test-master/output/filteredCountry.csv")

lowestPrice <- data.table(filteredCountry,key = 'SKU')
lowestPrice <- lowestPrice[,head(.SD,2),,by = c('SKU')]
View(lowestPrice)

lowestPrice <- lowestPrice[, c('SKU', 'PRICE')]
View(lowestPrice)
