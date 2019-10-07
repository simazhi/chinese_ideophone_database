start <- Sys.time()
library(tidyverse)
library(fs)
library(glue)
# library(furrr)
# future::plan(multisession)

words <- read_csv("list.of.traditional.ideophones.csv") 
words <- words %>%
  mutate(traditional = case_when(
    nchar(traditional) < 2 ~ str_replace(traditional, "(.)", " \\1_"),
    TRUE ~ traditional
  )) 
search.expressions <- pull(words)
#search.expressions

# files <- dir_ls("/Users/Thomas/Desktop/ASBC/tidy_ASBC_unnested",
#                     recurse = TRUE,
#                     regexp = ".rds$")

files <- dir_ls("tidy_ASBC_unnested",
                recurse = TRUE,
                regexp = ".rds$")

#search.expressions <- c("十二月", "必須")
search.2 <- glue_collapse(search.expressions, sep = "|")
search.2

# argList <- list(x = search.2, y = head(files))
# crossArg <- cross_df(argList)


finder <- function(file) {
  
  # read in file, select the variables I want
  current.file <- read_rds(file) %>% select(class, article.no, text)
  
  # is the search expression in the file
  final.file <- filter(current.file, str_detect(text, search.2))
  
  # write final table to the output file
  write_csv(final.file, "finder.results.csv", append = TRUE)
  #final.file

}


#map2_df(crossArg$x, crossArg$y, finder)
walk(files, finder)
#map2_dfr(crossArg$y, crossArg$x, finder)
end <- Sys.time()
end - start

# this is for reduced dataset
# add new column with search expression
#final.table <- mutate(filter.file, searchword = search.expression)


## POST PROCESSING
# map2_dfr(crossArg$y, crossArg$x, finder) -> r
# 
# r %>%
#   mutate(t = str_extract_all(text,search.2)) %>%
#   #select(t) %>%
#   unnest(t)



