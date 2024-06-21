Untitled
================

``` r
library(rhdx)
library(ncdf4) # package for netcdf manipulation
library(tidyverse)
library(data.table)

#remotes::install_github("dickoa/rhdx")

set_rhdx_config(hdx_site = "prod")
save(ke_food_prices, file = "data/ke_food_prices.rda")
ke_food_prices <- pull_dataset("wfp-food-prices-for-kenya") %>% 
    get_resource(1) %>%
    read_resource() %>%
    setDT()
```

``` r
nairobi <- ke_food_prices[admin2 == "Nairobi" & pricetype == "Wholesale",]

admin2_select <- c("Nairobi", "Mombasa", "Nakuru")

nmk_counties <- ke_food_prices[admin2 %in% admin2_select]

# commodotiy Maize filter
nmk_counties_maize <- nmk_counties[commodity == "Maize" & pricetype == "Wholesale",]

## group by date and get the mean price
nmk_counties_maize[, .(mean_price = mean(price)), by = .(date, admin2)] %>%
    ggplot(aes(x = date, y = mean_price, color = admin2)) +
    geom_line() +
    labs(title = "Maize Prices in Nairobi",
         x = "Date",
         y = "Mean Price") +
    scale_x_date(date_labels = "%Y-%m", breaks = "24 month") +
    theme_minimal()+
    theme(legend.position = "bottom")
```

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
## Last Run On
cat("Last Run On: ", Sys.time())
```

    ## Last Run On:  1718938115
