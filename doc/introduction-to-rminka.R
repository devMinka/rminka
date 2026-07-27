## ----setup--------------------------------------------------------------------
library(rminka)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----carga, include=FALSE-----------------------------------------------------
library(dplyr)
library(jsonlite)
library(httr)
#library(leaflet)
#library(magick)
library(rminka)
library(tibble)
library(knitr)

## ----install, eval = FALSE, echo= TRUE----------------------------------------
# pak::pak("Raiservi/rminka")

## ----project1, include = TRUE , echo=TRUE-------------------------------------
prj_names <- mnk_proj_byname("2025")

prj_names 

#In detail:

kable(prj_names[,c(1:5)])


## ----project_info, include = TRUE , echo=TRUE---------------------------------

prj_info <- mnk_proj_info(420)

prj_info

kable(as.data.frame(prj_info))


## ----project_info_users, include = TRUE , echo=TRUE---------------------------

prj_info_us <- mnk_proj_info(419, users = TRUE)

prj_info_us

kable(t(as.data.frame(prj_info_us)))


## ----user_name, include = TRUE , echo=TRUE------------------------------------

user_name <- mnk_user_byname("ramon")

user_name

kable(as.data.frame(user_name))

## ----user_project, include = TRUE , echo=TRUE---------------------------------

user_project <- mnk_user_proj(6)

user_project

kable(as.data.frame(user_project))

