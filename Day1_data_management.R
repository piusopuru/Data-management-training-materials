
#DATA MANAGEMENT COURSE SCRIPT1


install.packages("tidyverse")
install.packages("readxl")
install.packages("writexl")
install.packages("haven")
install.packages("data.table")
install.packages("rvest")

library(data.table) 
library(tidyverse)
library(haven)
library(readxl)
library(writexl)
library(rvest)


#1.Reading/importing Data:Can be done in different fomats
# Reads data from a CSV file.
kisumu_main_vendor <- read_csv("kisumu_main_vendor.csv")

# Reads data from a text file (more general than read.csv)
kisumu1 <- read.table("kisumu.txt")

# Reads data from an Excel file (requires the readxl package).
kisumu2 <-read_excel("kisumu.xlsx")

# Reads data from a Stata file (requires the haven package). 
kisumu3 <- read_dta("kisumu.dta")

# Reads data from a Stata file (requires the haven package). 
kisumu4 <- read_xpt("kisumu.sas")

# Read animal health data
Animal_Data <- read_csv("YSM Animal Health Data.csv")

#Read data from the web
url <- paste0("https://stats.oecd.org/sdmx-json/data/DP_LIVE/",
              ".M3.TOT.IDX2015.M/OECD?contentType=csv&detail=code",
              "&separator=comma&csv-lang=en&startPeriod=2012")
df <- read.csv(url)

#2. Data Structure Inspection:
# View the data set
View(kisumu1)
#Displays the structure of a data frame (data types and first few observations).
str(kisumu_main_vendor)
#Shows the first few rows of the data frame
head(kisumu_main_vendor)
#Shows the last few rows of the data frame.
tail(kisumu_main_vendor)
#Returns the dimensions (rows and columns) of the data frame
dim(kisumu_main_vendor)
#Returns the column names of the data frame. 
names(kisumu_main_vendor)


#3. Filtering Rows (using dplyr): 
  filter(data, condition)
#Selects rows that satisfy the given condition.
#Example:  selects rows where the county column is kisumu
obungaslum <- filter(kisumu_main_vendor, slum == "Obunga")

Male <- filter(kisumu_main_vendor, gender == "Male")

obungamale <- filter(kisumu_main_vendor, slum == "Obunga" & gender =="Male")

#Example:  selects rows where the animal age is less than 12 weeks
data <- filter(Animal_Data, age < 12)

#4. arrange data/sort data using the arrange function
#Example: Sort the age in ascending order 
data1 <- arrange(Animal_Data, age)  
#Sort age in ascending order
data2 <- arrange(Animal_Data,(-age)) 

#5. Selecting Columns (using dplyr): 
 # select(data, column_names)
#Selects specific columns by name.
#Example:  selects the "age", "age_weeks", "age_units" columns.
data3 <- select(Animal_Data,age,age_weeks,age_units) 
data4 <- select(kisumu_main_vendor,consent,county,location_type)
#Example:  selects all columns except "subcounty"
data5 <- select(kisumu_main_vendor,-subcounty)  
#Select colunms starting with certain letters,ends with or contains
data6 <- select(kisumu_main_vendor, starts_with("s")) 


#6. Mutating (Creating New Variables) (using dplyr): 
  # mutate(data, new_variable = expression)
#Creates a new variable based on an expression involving existing variables.
#Example: creates a new variable "new_age" by squaring the "age" variable 
new_age <- mutate(Animal_Data, new_age = age^2)

##mutate
logage <- mutate(Animal_Data, logage = log(age))

#7. rename columns using rename() 
#creates new names for variables in the data set
#Example: rename id to vendor_id in kisumu1 data set
data7 <- rename(kisumu1, location = region)

#8.relocate() gives new order to column names
#Example: relocate/reorder slum, ward and subcounty from their original order
kisumu1 <- relocate(kisumu1, slum, ward, subcounty)


#9. Exporting data out of R
write_csv(logage,"logage.csv")
write_xlsx(Male,"Male.xls")
write_dta(data4,"data4.dta")
write_sav(obungamale,"obungamale.sav")
write_xpt(obungaslum, "obungaslum.sas")
write.table(df,"df.txt")

