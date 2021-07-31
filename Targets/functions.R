library(xml2)
library(tidyverse)
library(jsonlite)
library(rvest)

scrape_clean_fire_data<-function(years){
  
  
  
  url_list<-(sprintf("https://www.fire.ca.gov/incidents/%i/",years))
  
  html_object<-lapply(url_list,read_html)
  

  json_list<-lapply(html_object, function(html_reading){
    tablefinder<-html_reading %>% html_nodes('body') %>% 
      xml_find_all("//div[contains(@id, 'incidentListTable')]") %>% 
      html_children()
    
    jsonstring<-tablefinder[2] %>% html_text()
    jsonstring<-jsonstring %>% str_replace(".* = ", "") %>% str_replace("\r\n","")
    jsonstring<-gsub(";\r\n.*","",jsonstring)
    
    class(jsonstring)<-"json"
    
    return(jsonstring)
  
  })
  
  data_tables<-lapply(json_list,fromJSON)
  
  return(data_tables)

  
  
}
