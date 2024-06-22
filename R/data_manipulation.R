
library(tidyverse)
library(data.table)

library(rhdx)
set_rhdx_config(hdx_site = "prod")

search_datasets("Kenya rainfall")
ke_food_prices <- pull_dataset("wfp-food-prices-for-kenya") %>% 
    get_resource(1) %>%
    read_resource() %>%
    setDT()

ke_rainfall_data <- pull_dataset("ken-rainfall-subnational") %>% 
    get_resource(1) %>%
    read_resource() %>%
    setDT()

save(ke_food_prices, file = "data/ke_food_prices.rda")
save(ke_rainfall_data, file = "data/ke_rainfall_data.rda")
# "data/ke_food_prices.rda"

load("data/ke_food_prices.rda")
load("data/ke_rainfall_data.rda")


admin2_code <- ke_rainfall_data[, unique(ADM2_PCODE)]
names(ke_food_prices)

#  group by  "category"  "commodity" ""      "priceflag" "pricetype" 

categories <- ke_food_prices[, .(freq = .N), by = .(category, commodity, priceflag, pricetype)] [order(-freq)]
