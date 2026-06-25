# install.packages("tidyverse")
# install.packages("palmerpenguins")
# install.packages("plotly")

library(tidyverse)
library(palmerpenguins)
library(plotly)

# head(penguins)
# summary(penguins)
# dim(penguins)
# names(penguins)
# str(penguins)
# View(penguins)

# Q1: Heaviest Species
#------------------------------------------------------------------------------

# Filter data
avg_mass_by_species <- penguins %>%
  group_by(species) %>%
  summarise(
    n_penguins = sum(!is.na(body_mass_g)),
    avg_mass = mean(body_mass_g, na.rm=TRUE),
    .groups = "drop"
    ) %>%
  arrange(desc(avg_mass)) %>%
  mutate(species = factor(species, levels = species))
print(avg_mass_by_species)

# Create static ggplot
species_mass_plot <- ggplot(
  avg_mass_by_species,
  aes(
    x = species,
    y = avg_mass,
    fill = species,
    text = paste(
      "Species:", species,
      "<br>Average Mass:", round(avg_mass, 1), " g",
      "<br>Penguins:", n_penguins
    )
  )
) + 
  geom_col() +
  labs(
    title = "Average Body Mass by Penguin Species",
    x = "Species",
    y = "Average Body Mass (g)"
  ) +
  theme_classic() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_line(
      colour = "grey85",
      linewidth = 0.3
      ),
    panel.grid.minor.y = element_line(
      colour = "grey92",
      linewidth = 0.2
      )
    )
species_mass_plot

# Interactive version
species_mass_plot_interactive <- ggplotly(
  species_mass_plot,
  tooltip = "text"
)
species_mass_plot_interactive


# Save static plot image
if (!dir.exists("output")) {
  dir.create("output")
}
if (!dir.exists("output/static")) {
  dir.create("output/static")
}
if (!dir.exists("output/interactive")) {
  dir.create("output/interactive")
}

ggsave(
  "output/static/species_mass_plot.png",
  plot = species_mass_plot,
  width = 8,
  height = 5
)

htmlwidgets::saveWidget(
  species_mass_plot_interactive,
  "output/interactive/species_mass_plot.html",
  selfcontained = TRUE
)
browseURL("output/interactive/species_mass_plot.html")

# Q2: Males vs Female weight
#------------------------------------------------------------------------------

avg_mass_by_sex <- penguins %>%
  mutate(sex = ifelse(is.na(sex), "Unknown", as.character(sex))) %>%
  group_by(sex) %>%
  summarise(
    n_penguins = sum(!is.na(body_mass_g)),
    avg_mass = mean(body_mass_g, na.rm=TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_mass))
print(avg_mass_by_sex)


