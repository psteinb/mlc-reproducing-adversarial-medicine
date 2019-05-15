library(dplyr)
library(readr)
library(stringr)
library(tidyr)


df = read_csv("Data_Entry_2017.csv") %>% select(c(1,2))

colnames(df)[1] = "image_id"
colnames(df)[2] = "level"

nofi = df %>% filter(stringr::str_detect(level, 'No Finding') & !stringr::str_detect(level, 'Pneumothorax')) %>% mutate(malignant = F)
pneu = df %>% filter(!stringr::str_detect(level, 'No Finding') & stringr::str_detect(level, 'Pneumothorax')) %>% mutate(malignant = T)

ds = nofi %>% bind_rows(pneu)

ds %>% group_by(malignant) %>% tally()
