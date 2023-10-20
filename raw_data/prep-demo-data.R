library(bcdata)
library(rmapshaper)
library(sf)
library(elevatr)
library(dplyr)
library(readr)

bcdc_get_data("bc-airports",
              resource = '4d0377d9-e8a1-429b-824f-0ce8f363512c') %>%
  select(AIRPORT_NAME, IATA_CODE, LOCALITY, ELEVATION,
         NUMBER_OF_RUNWAYS) %>%
  st_write("raw_data/bc_airports.gpkg", layer = "bc_airports",
           delete_layer = TRUE)

bcdc_get_data("current-provincial-electoral-districts-of-british-columbia",
              resource = "89de1e77-9e33-41dd-bf6f-34e6d664b89a") %>%
  st_transform(4326) %>%
  ms_simplify() %>%
  st_write("raw_data/bc_electoral_districts.shp",
           layer = "bc_electoral_districts", delete_layer = TRUE)

# ski resorts csv
bcdc_get_data("db1489d4-4304-4203-99bf-11b2b23179eb") %>%
  get_elev_point(src = "aws") %>%
  select(FACILITY_NAME, LOCALITY, LATITUDE, LONGITUDE, elevation) %>%
  rename_all(tolower) %>%
  st_drop_geometry() %>%
  write_csv("raw_data/ski_resorts.csv")


