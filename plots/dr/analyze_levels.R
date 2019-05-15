library(dplyr)
library(readr)
library(ggplot2)

df = read_csv("trainLabels.csv") 
ds = read_csv("sampleSubmission.csv")
df = df %>% bind_rows(ds)

overview = df %>% group_by(level) %>% tally()

repro = df %>% mutate(malignant = level <= 2) %>% group_by(malignant) %>%tally()
head(repro)

pl = ggplot(overview, aes(as.factor(level),n))
pl = pl + geom_bar(stat = "identity")
pl = pl + xlab("Class Label")
pl = pl + ylab("N(images)")
pl = pl + theme_light()

ggsave("dr_overview.svg",pl)
ggsave("dr_overview.png",pl)
