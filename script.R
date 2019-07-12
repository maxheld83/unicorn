source("import.R")
library(tidyverse)
weighted <- inner_join(x = data$votes, y = data$tweets, by = "status") %>%
  mutate(votes = (votes_total * vote_share)) %>%
  mutate(votes = as.integer(votes)) %>%
  group_by(status) %>%
  mutate(votes_per_choices = votes/n()) %>%
  ungroup() %>%
  mutate(votes_weighted = votes_per_choices/impressions) %>%
  group_by(name) %>%
  summarise(
    suggester = paste(unique(suggester), collapse = ", "),
    votes_raw = sum(votes),
    votes_weighted = sum(votes_weighted)
  )
library(ggrepel)
first_round <- ggplot(
  data = weighted,
  mapping = aes(
    x = votes_raw,
    y = votes_weighted,
    label = name,
    color = suggester
  )
) +
  geom_point() +
  xlab(label = "Votes") +
  ylab(label = "Votes Weighted By Alternatives and Impressions") +
  ggrepel::geom_label_repel(show.legend = FALSE) +
  theme(legend.position = "bottom") +
  labs(color = "Suggested by")

ggsave(
  filename = "first_round.png",
  plot = first_round,#
  device = "png",
  width = 9,
  height = 7,
  dpi = 320
)
