# Bungee-coding-round using R language


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

lowestPrice1 <- data.table(filteredCountry,key = 'SKU')
lowestPrice1 <- lowestPrice[,head(.SD,2),,by = c('SKU')]
#View(lowestPrice1)

lowestPrice1 <- lowestPrice1[, c('SKU', 'PRICE')]
#View(lowestPrice1)
first <- lowestPrice1[, .SD[1], by=c('SKU')]
last <- lowestPrice1[, .SD[.N], by=c('SKU') ]
last <- last[-1,]
last <- last[-1,]

setnames(first, c('PRICE'), c('FIRST_MINIMUM_PRICE'))
setnames(last, c('PRICE'), c('SECOND_MINIMUM_PRICE'))


lowestPrice <- merge(first, last, by=c('SKU'), all = TRUE)
lowestPrice <- lowestPrice[, `SECOND_MINIMUM_PRICE` := ifelse(is.na(`SECOND_MINIMUM_PRICE`), 0, `SECOND_MINIMUM_PRICE`)]
View(lowestPrice)
fwrite(lowestPrice, "E:/Program Files/R/R-4.0.3/intership-test-master/output/lowestPrice.csv")

