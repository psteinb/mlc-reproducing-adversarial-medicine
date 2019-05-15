library(dplyr)
library(readr)
library(ggplot2)

df = read_csv("trainLabels.csv") 
ds = read_csv("sampleSubmission.csv")
df = df %>% bind_rows(ds)

overview = df %>% group_by(level) %>% tally()

overview$levels_fct = factor(overview$level)
## grade 2 or worse
overview = overview %>% mutate(malignant = ifelse(level <= 2,"healthy","malignant"))


levels(overview$levels_fct)
levels(overview$levels_fct) = c("No DR", "Mild", "Moderate", "Severe", "Proliferative DR")
head(overview)

repro = df %>% mutate(malignant = level <= 2) %>% group_by(malignant) %>%tally()
head(repro)

pl = ggplot(overview, aes(levels_fct,n, fill=reorder(malignant, desc(malignant))))
pl = pl + geom_bar(stat = "identity")
pl = pl + scale_fill_discrete(name="Medical Status")
pl = pl + xlab("Class Label")
pl = pl + ylab("N(images)")
pl = pl + theme_light()

ggsave("dr_overview.svg",pl)
ggsave("dr_overview.png",pl)
