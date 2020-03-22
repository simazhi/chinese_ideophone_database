#library(tidyverse)
library(dplyr)
library(tibble)
library(magrittr)
library(readr)
library(purrr)
library(rvest)
library(glue)
library(here)

# function definition

zdicfinder <- function(SEARCHWORD){
  
  url <- glue("https://www.zdic.net/hans/{SEARCHWORD}")

  cat(glue("{SEARCHWORD}      "))
  
  page <- read_html(url)
  finaltable <- page %>%
    html_nodes('[class="gycd-item"]') %>%
    #html_nodes(xpath = '//*[@id="126006_1"]/div[2]/div[3]/div/ol/div[1]') %>%
    html_text() %>%
    enframe() %>%
    mutate(ideo = SEARCHWORD)

  write_csv(finaltable, here(#"zdic", 
			     "zdicwords.csv"),
              append = TRUE)
  
  Sys.sleep(5) # sleep 5 seconds
}

# wrap in possibly
zdicfinder_poss <- possibly(zdicfinder, otherwise = NA)

# read in the list of ideophones
targets <- read_csv(here(#"zdic",
                         "zdicideophonestargets.csv")) %>% pull() %>% sort()
targets2 <- c("咻咻", "汪汪")

# run function
walk(targets2, zdicfinder_poss)
walk(targets, zdicfinder_poss)

