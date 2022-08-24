library(neuralnet)
library(caret)
library(tidyverse)
library(mlbench)
library(e1071)


df <- read.csv("diabetes.csv")
str(df)

df %>%
  janitor::clean_names() %>% 
  dplyr::rename(pregnant = pregnancies,
                pressure = blood_pressure,
                triceps = skin_thickness,
                mass = bmi,
                pedigree = diabetes_pedigree_function,
                diabetes = outcome) -> df


