## code to prepare `DATASET` dataset goes here

usethis::use_data(DATASET, overwrite = TRUE)


library(tidyverse)

npp <- read_csv("data-raw/dendroadaptamed_npp_modis.csv") |>
  dplyr::select(year, sp_code, elev_code, sp_elev, npp)

annual_pet <- read_csv("data-raw/dendroadaptamed_spei_climate.csv") |>
  dplyr::select(sp_elev, year, monthly_pet, monthly_tmed, monthly_prec) |>
  group_by(sp_elev, year) |>
  summarise(pet = sum(monthly_pet),
            prec = sum(monthly_prec),
            temp = mean(monthly_tmed, na.rm = TRUE)) |>
  rowwise() |>
  mutate(water_balance = prec - pet)

npp_pinus  <- npp |>
  inner_join(annual_pet)

npp_pinus <- npp_pinus |>
  filter(prec < 1000)

# Get init
init_logis_npp <- as.data.frame(t(getInitial(npp ~ SSlogis(prec, Asym, xmid, scal), data = npp_pinus)))


ggplot(npp_pinus, aes(x = prec, y = npp)) +
  geom_point() +
  geom_smooth(aes(),
            data = npp_pinus,
            method = "nls",
            formula=y~SSlogis(x, Asym, xmid, scal),
            se =  FALSE, # this is important
            method.args =list(start=init_logis_npp,
                              control=nls.control(maxiter=1000)),
            size = 1, colour = "black")






usethis::use_data(npp_pinus, overwrite = TRUE)

