library(dplyr)
library(readr)

df = read_csv("trainLabels.csv") 
ds = read_csv("sampleSubmission.csv")
df = df %>% bind_rows(ds)

df %>% group_by(level) %>% tally()

df %>% mutate(malignant = level <= 2) %>% group_by(malignant) %>%tally()