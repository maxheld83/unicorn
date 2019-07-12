if (FALSE) {
  library(googlesheets)
  unicorn <- gs_key(x = "1WEvq7XKALZcNlKc09rPYI9vcIFTAJUXrRwHCRhQ6GYI")
  votes <- gs_read(ss = unicorn, ws = "votes", col_types = "ccdc")
  tweets <- gs_read(ss = unicorn, ws = "tweets", col_types = "ciii")
  readr::write_rds(x = list(votes = votes, tweets = tweets), path = "data.rds")
}
data <- readr::read_rds(path = "data.rds")
