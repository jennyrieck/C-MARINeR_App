library(shiny)
library(CovSTATIS)
library(magrittr)
library(GSVD)
library(ggplot2)

moduleFiles = list.files('modules',full.names = TRUE) %>% sapply(source,.GlobalEnv)

