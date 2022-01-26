#load data
library(tidyverse)
dat<-read.csv("Data/master_ca_fire.csv")


summary_stats <- dat %>% drop_na(AcresBurned) %>% 
  group_by(Counties) %>% 
  summarise(
    n = n(),
    acres_burned = sum(AcresBurned)) %>% 
  filter(Counties != "State of Oregon" & Counties != "State of Nevada")


library(rvest)

page<-read_html("https://moodle2.sscnet.ucla.edu/mod/resource/index.php?id=17540")
list<-page %>% html_nodes("a") %>% html_attr("href")
View(data.frame(list))

