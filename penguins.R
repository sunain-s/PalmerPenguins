# install.packages("tidyverse")
# install.packages("palmerpenguins")

library(tidyverse)
library(palmerpenguins)

# head(penguins)
# summary(penguins)
# dim(penguins)
# names(penguins)
# str(penguins)

# Heaviest Species
#------------------------------------------------------------------------------

# Filter data
avg_mass_by_species <- penguins %>%
  group_by(species) %>%
  summarise(avg_mass = mean(body_mass_g, na.rm=TRUE),
            .groups = "drop") %>%
  arrange(desc(avg_mass)) %>%
  mutate(species = factor(species, levels = species))
avg_mass_by_species

# Plot data
species_mass_plot <- ggplot(avg_mass_by_species,
       aes(x = species, y = avg_mass, fill = species)) + 
  geom_col() +
  labs(title = "Average Body Mass by Penguin Species",
       x = "Species",
       y = "Average Body Mass (g)"
       ) + 
  theme_classic() +
  theme(legend.position = "none",
        panel.grid.major.y = element_line(
          colour = "grey85",
          linewidth = 0.3
        ),
        panel.grid.minor.y = element_line(
          colour = "grey92",
          linewidth = 0.2
        ))
species_mass_plot

# Save plot image
if (!dir.exists("output")) {
  dir.create("output")
}
ggsave(
  "output/species_mass_plot.png",
  plot = species_mass_plot,
  width = 8,
  height = 5
)





