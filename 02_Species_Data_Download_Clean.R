#Species occurrence records download and clean
#here just list a example

#To obtain occurrence records, we access data from GBIF via the R package rgbif
library(rgbif) 

key<-name_suggest(q="Dasyprocta punctata",rank = 'species')$data$key[1]
n<-occ_count(taxonKey = key,georeferenced = T)
n

dat<-occ_search(scientificName = "Dasyprocta punctata",
                  hasCoordinate = T,
                  limit = n)

dat<-dat$dat
names(dat)

# We'll now examine the data (by removing the hash)
# names(dat) # a lot of columns
# Let's select the columns of interest. We will also rename the longitude and latitude columns

library(dplyr)#筛选
dat <- dat %>% 
  dplyr::select(species, 
                decimallongitude = decimalLongitude,
                decimallatitude = decimalLatitude, 
                individualCount, 
                gbifID, 
                family, 
                taxonRank, 
                coordinateUncertaintyInMeters, 
                year, 
                basisOfRecord, 
                institutionCode, 
                datasetName)

# Remove records without coordinates
dat <- dat %>% 
  filter(!is.na(decimallongitude), !is.na(decimallatitude))

library(ggplot2)
ggplot() + 
  coord_fixed() + 
  borders("world", colour = "gray50", fill = "gray50") +
  geom_point(data = dat, aes(x = decimallongitude, y = decimallatitude),
             colour = "darkred", size = 1.5) +
  theme_bw()

# We will use the R package CoordinateCleaner to automatically flag problematic records from 
# biological collections, such as:
# Sea coordinates
# Zero coordinates
# Coordinate - country mismatches
# Coordinates assigned to country and province centroids
# Coordinates within city areas
# Outlier coordinates
# Coordinates assigned to biodiversity institutions.

# We’ll run the automatic cleaning algorithm to flag errors that are common to 
# The magrittr pipe (%>%) will be used to run tests implemented in CoordinateCleaner 
# with a individual function and connect them using the magrittr pipe operator, which 
# will directly result in a data.frame comprising only cleaned records

library(CoordinateCleaner)
clean <- dat %>%
  cc_val() %>% # Removes or flags non-numeric and not available coordinates as well as lat >90, la <-90, lon > 180 and lon < -180 are flagged
  cc_equ() %>% # Removes or flags records with equal latitude and longitude coordinates, either exact or absolute. Equal coordinates can often indicate data entry errors.
  cc_cap() %>% # Removes or flags records within a certain radius around country capitals. Poorly geo-referenced occurrence records in biological databases are often erroneously geo-referenced to capitals
  cc_cen() %>% # Removes or flags records within a radius around the geographic centroids of political countries and provinces. Poorly geo-referenced occurrence records in biological databases are often erroneously geo-referenced to centroids
  cc_gbif() %>% # Removes or flags records within 0.5 degree radius around the GBIF headquarters in Copenhagen, DK
  cc_inst() %>% # # Removes or flags records assigned to the location of zoos, botanical gardens, herbaria, universities and museums, based on a global database of ~10,000 such biodiversity institutions. Coordinates from these locations can be related to data-entry errors, false automated geo-reference or individuals in captivity/horticulture
  cc_sea() %>% # # Removes or flags coordinates outside the reference landmass. Can be used to restrict datasets to terrestrial taxa, or exclude records from the open ocean, when depending on the reference (see details). Often records of terrestrial taxa can be found in the open ocean, mostly due to switched latitude and longitude
  cc_zero() %>% # # Removes or flags records with either zero longitude or latitude and a radius around the point at zero longitude and zero latitude. These problems are often due to erroneous data-entry or geo-referencing and can lead to typical patterns of high diversity around the equator
  cc_dupl(lon = "decimallongitude", lat = "decimallatitude") # Removes or flags duplicated records based on species name and coordinates, as well as user-defined additional columns

#In this way using the magrittr pipe operator, you can also add the individual test results from CoordinateCleaner functions as columns to your initial data.frame:
dat %>%
  as_tibble() %>% 
  mutate(val = cc_val(., value = "flagged"),
         sea = cc_sea(., value = "flagged"))

#Let’s visualise the cleaned data on a map after using the CoordinateCleaner functions
ggplot() + 
  coord_fixed() + 
  borders("world", colour = "gray50", fill = "gray50") +
  geom_point(data = clean, aes(x = decimallongitude, y = decimallatitude),
             colour = "darkred", size = 1.5) +
  theme_bw()


#Remove records with low coordinate precision
hist(clean$coordinateUncertaintyInMeters / 1000, breaks = 20)

#Let’s remove coordinates with coordinate precision < 1km
dat_cl <- clean %>%
  filter(coordinateUncertaintyInMeters < 1000 | is.na(coordinateUncertaintyInMeters))

#After removing coordinates with uncertainty of 1km, here is the histogram of the coordinate precision for the remaining records
hist(dat_cl$coordinateUncertaintyInMeters / 1000, breaks = 20)

#Remove unsuitable data sources, especially fossils which are responsible for the majority of problems in this case. 
#The removal of other record types will depend on the questions to be addressed
table(dat_cl$basisOfRecord)

dat_cl <- filter(dat_cl, 
                 basisOfRecord == "MACHINE_OBSERVATION" | 
                   basisOfRecord == "HUMAN_OBSERVATION" | 
                   basisOfRecord == "OBSERVATION" |
                   basisOfRecord == "PRESERVED_SPECIMEN")

#In the next step we will remove records with suspicious individual counts. 
#GBIF includes few records of absence (individual count = 0) and suspiciously high occurrence counts, 
#which might indicate inappropriate data or data entry problems
table(dat_cl$individualCount)

dat_cl <- dat_cl %>%
  filter(individualCount > 0 | is.na(individualCount)) %>%
  filter(individualCount < 99 | is.na(individualCount)) 

#We might also want to exclude old records, as they are more likely to be unreliable. 
#For instance, records from before the second world war are often very imprecise,
#especially if they were geo-referenced based on political entities. 
#Additionally old records might be likely from areas where species went extinct (for example due to land-use change). 
#As we are using Worldclim v.1 climate data later, it also coincides with the current conditions

# Age of records
table(dat_cl$year)

# Remove records from after 1970. 
dat_cl <- dat_cl %>%
  filter(year >= 1970) 

# On top of the geographic cleaning, we also want to make sure to only include species level records and records from the right taxon. 
# The latter is not a problem in this case, as we only have one species, but it can be helpful for large datasets. 
# Taxonomic problems such as spelling mistakes in the names or synonyms can be a severe problem. 
# We’ll not treat taxonomic cleaning here, but if you need to, check out the R package taxize or the taxonomic name 
# resolution service (plants only).
table(dat_cl$family) 

dat_cl <- dat_cl %>%
  filter(family == 'Dasyproctidae')
table(dat_cl$taxonRank)

#Let’s visualise the cleaned data on a map after the cleaning of the meta-data
ggplot() + 
  coord_fixed() + 
  borders("world", colour = "gray50", fill = "gray50") +
  geom_point(data = dat_cl, aes(x = decimallongitude, y = decimallatitude),
             colour = "darkred", size = 1.5) +
  theme_bw()


#Improving data quality using external information

#The first option is to exclude records outside a certain study extent. 
#In our example this is the easiest solution because we know that 
#D. punctata native range is below -3 degrees latitude and -50 degree latitude

dat_loc <- dat_cl %>% 
  filter(decimallatitude > -3 & decimallongitude < -50) 

#Let’s visualise the cleaned data on a map after the cleaning based on records
ggplot() + 
  coord_fixed() + 
  borders("world", colour = "gray50", fill = "gray50") +
  geom_point(data = dat_loc, aes(x = decimallongitude, y = decimallatitude),
             colour = "darkred", size = 1.5) + 
  xlim(min(dat_loc$decimallongitude - 5, na.rm = TRUE), max(dat_loc$decimallongitude + 5, na.rm = TRUE)) + 
  ylim(min(dat_loc$decimallatitude - 5, na.rm = TRUE), max(dat_loc$decimallatitude + 5, na.rm = TRUE)) +
  theme_bw()

#We’ll now use the IUCN range maps for cleaning geographic species occurrence data
nat_range <- read_sf("E:/RStudio/RStudio-1.4.1717/bin/CleanSpeciesData/Dasyprocta punctata/data_0.shp")

#Let’s convert the cleaned occurrence records to a sf object and assign to a sf object
occurrence <- dat_loc[ , c('decimallongitude', 'decimallatitude')] %>% 
  as.matrix(.) %>% 
  st_multipoint() %>% 
  st_sfc(crs = st_crs(nat_range)) %>% 
  st_cast('POINT')

#We then remove the locations within the range
within <- st_intersects(occurrence, nat_range) %>% 
  as.matrix() 

dat_iucn <- dat_loc[within, ]

#visualise the locations
ggplot() +
  borders("world", colour="gray50", fill="gray50") +
  geom_sf(data = nat_range) +
  geom_point(data = dat_loc[!within, ], aes(x = decimallongitude, y = decimallatitude), colour = "blue", size = 3.5, alpha = 1) +
  geom_point(data = dat_iucn, aes(x = decimallongitude, y = decimallatitude), colour = "darkred", size = 2.5, alpha = 1) +
  theme_bw() +
  theme(legend.position = "none",
        axis.title = element_blank()) +
  coord_sf(xlim = c(min(dat_loc$decimallongitude - 5, na.rm = TRUE), max(dat_loc$decimallongitude + 5, na.rm = TRUE)), 
           ylim = c(min(dat_loc$decimallatitude - 5, na.rm = TRUE), max(dat_loc$decimallatitude + 5, na.rm = TRUE))) 

#now have a cleaned dataset for D. punctata occurrence records. We can now save them for future analyses
write_csv(x = dat_iucn, path = "CleanSpeciesData/dat_iucn.csv") 
