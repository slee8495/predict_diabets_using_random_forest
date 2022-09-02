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
                binary = outcome) %>% 
  dplyr::mutate(diabetes = recode(binary, "0" = "neg", "1" = "pos")) %>% 
  dplyr::relocate(diabetes, .before = binary) -> df



ggplot2::ggplot(data = df, mapping = aes(x = diabetes, fill = factor(diabetes))) +
  ggplot2::geom_bar()


# Now, data partition part

rows <- caret::createDataPartition(df$binary, times = 1, p = 0.7, list = FALSE)


train <- df[rows, ]
train %>% 
  dplyr::select(-diabetes) -> train


test <- df[-rows, ]
test %>% 
  dplyr::select(-diabetes) -> test




# Creating Models

model <- train(as.factor(binary) ~ .,
               data = train,
               method = "ranger",
               trControl = caret::trainControl(method = "repeatedcv", number = 2, repeats = 2))



