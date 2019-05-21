library(shiny)
library(covstatis)
library(magrittr)
library(GSVD)

moduleFiles = list.files('modules',full.names = TRUE) %>% sapply(source,.GlobalEnv)

