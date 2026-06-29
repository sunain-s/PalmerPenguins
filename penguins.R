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

dir.create("output/static", recursive = TRUE, showWarnings = FALSE)
dir.create("output/interactive", recursive = TRUE, showWarnings = FALSE)

# Save plots
save_plot <- function(plot, 
                      filename, 
                      width = 8, 
                      height = 5, 
                      static = TRUE, 
                      interactive = TRUE, 
                      open = FALSE) {
  if (static) {
    ggsave(
      filename = paste0("output/static/", filename, ".png"),
      plot = plot,
      width = width,
      height = height
    )
  }
  
  if (interactive) {
    htmlwidgets::saveWidget(
      ggplotly(plot),
      paste0("output/interactive/", filename, ".html"),
      selfcontained = TRUE
    )
      if (open) {
        browseURL(paste0("output/interactive/", filename, ".html"))
      }
  }
  
}

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

save_plot(species_mass_plot, "species_mass_plot", open = TRUE)

# Q2: Males vs Female weight
#------------------------------------------------------------------------------

# Filter data
avg_mass_by_sex <- penguins %>%
  mutate(
    sex = replace_na(as.character(sex), "Unknown")
    ) %>%
  group_by(sex) %>%
  summarise(
    n_penguins = sum(!is.na(body_mass_g)),
    avg_mass = round(mean(body_mass_g, na.rm=TRUE), 1),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_mass))
print(avg_mass_by_sex)

# Create box plot
sex_box_plot <- penguins %>%
  filter(!is.na(sex), !is.na(body_mass_g)) %>%
  ggplot(
    aes(x = sex, 
        y = body_mass_g, 
        fill = sex
        )
    ) +
  geom_boxplot() +
  labs(
    title = "Body Mass Distribution by Sex",
    x = "Sex",
    y = "Body Mass (g)"
  ) +
  theme_classic() +
  theme(
    legend.position = "none"
  )
sex_box_plot

save_plot(sex_box_plot, "sex_box_plot", open = TRUE)





