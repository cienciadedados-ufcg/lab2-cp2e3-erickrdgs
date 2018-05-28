library(tidyverse)
library(here)
library(spotifyr)

# Você precisará pegar um id e segredo para seu código aqui: https://developer.spotify.com/my-applications/#!/applications 
# 
chaves = read_csv(here::here("code/chaves-do-spotify.csv"), 
                  col_types = "cc")

Sys.setenv(SPOTIFY_CLIENT_ID = pull(chaves, client_id))
Sys.setenv(SPOTIFY_CLIENT_SECRET = pull(chaves, client_secret))

# Autentica com a API e pega token para usar os endpoints 
access_token <- get_spotify_access_token()

# Da maneira como é feito nesse script, você PRECISARÁ RODAR get_artist_audio_features()
# INTERATIVO, PARA UM ARTISTA POR VEZ, para que o terminal lhe pergunte que artista 
# exatamente você quer analisar. 
lua <- get_artist_audio_features('luiz gonzaga') %>% 
    mutate(artist = "Luiz Gonzaga")

jackson <- get_artist_audio_features('jackson do pandeiro')
jackson %>% 
    mutate(artist = "Jackson do Pandeiro") 

jackson %>% 
    bind_rows(lua) %>% 
    write_csv(here("data/forro_do_gogó_ao_mocotó.csv"))

am <- get_artist_audio_features("arctic monkeys")

am$album_img <- NULL

am <- am %>%
    mutate(artist = "Arctic Monkeys")

am <- am[,c(23,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22)]

shadowPuppets <- get_artist_audio_features("the last shadow puppets")

shadowPuppets$album_img <- NULL

shadowPuppets <- shadowPuppets %>%
    mutate(artist = "The Last Shadow Puppets")

shadowPuppets <- shadowPuppets[,c(23,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22)]

am <-am %>%
    bind_rows(shadowPuppets)

am$album_release_year <- as.numeric(am$album_release_year)

am$album_release_year[am$album_release_year == 13200] <- 2006
am$album_release_year[am$album_release_year == 13625] <- 2007
am$album_release_year[am$album_release_year == 14039] <- 2008
am$album_release_year[am$album_release_year == 14481] <- 2009
am$album_release_year[am$album_release_year == 15132] <- 2011
am$album_release_year[am$album_release_year == 15958] <- 2013
am$album_release_year[am$album_release_year == 16892] <- 2016
am$album_release_year[am$album_release_year == 17662] <- 2018

am %>%
    write_csv(here("data/alex_turner.csv"))

pilots <- get_artist_audio_features("Twenty One Pilots")

pilots$album_img <- NULL

pilots <- pilots %>%
    mutate(artist = "Twenty One Pilots")

pilots <- pilots[,c(23,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22)]

pilots %>%
    write_csv(here("data/21_pilots.csv"))
