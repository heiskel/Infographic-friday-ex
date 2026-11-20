# -------------------------------------------------------
# Project: Sleep infographic
# Author: Ulrik H
#
# Description:
# Comparing the effects of two sleep inducing drugs.
#
# Data:
# Sleep dataset built in R.
#
# Arguments:
# None - the script uses a built-in dataset.
#
# Requirements:
# R and the tidyverse package
#
# Run from the repository root:
# Rscript sleep-info.R
#
# Output:
# sleep-info.PNG
# -------------------------------------------------------


library(tidyverse)

sleep = datasets::sleep

Header = "Which drug increases sleep duration the most?"

subtitle = "Comparing the effects of two sleep-inducing drugs on 10 participants."

conlusion = "Drug B increased sleep duration by an average of 1.58 hours more than Drug A."

sleep_summary = sleep |> 
  group_by(group) |> 
  summarise(mean_extra = mean(extra))

ggplot(sleep_summary, aes(x=group, y=mean_extra, fill = group)) +
  geom_col() + 
  labs(
    title = Header,
    subtitle = subtitle,
    x = NULL,
    y = "Average additional sleep (hours)",
    caption = conlusion
  ) +
  coord_flip() +
  theme_minimal() +
  theme(
    plot.background = element_rect(
      fill = "#F8F5EF",
      colour = NA
    ),
    panel.background = element_rect(
      fill = "#F8F5EF",
      colour = NA
    ),
    plot.title = element_text(
      colour = "#263344",
      size = 22,
      face = "bold"
    ),
    plot.subtitle = element_text(
      colour = "#7D858C"
    ),
    plot.caption = element_text(
      size = 11,
      face = "bold",
      colour = "#263344",
      hjust = 0
    ),
    plot.margin = margin(20, 30, 20, 30),
    legend.position = "none",
    panel.grid = element_blank(),
    axis.title.y = element_blank(),
  ) +
  scale_x_discrete(labels = c("Drug A", "Drug B")) +
  geom_text(
    aes(label = round(mean_extra, 2)),
    hjust = 1.2,
    colour = "white",
    fontface = "bold",
    size = 5
  ) +
  scale_fill_manual(
    values = c(
      "1" = "#88A9C4",
      "2" = "#C87559"
    )
  )

ggsave("sleep-info.png", width = 8, height = 5, dpi = 300)
