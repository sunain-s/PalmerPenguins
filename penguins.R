# install.packages("tidyverse")
# install.packages("palmerpenguins")

library(tidyverse)
library(palmerpenguins)

head(penguins)
summary(penguins)
dim(penguins)
names(penguins)
str(penguins)


# Heaviest Species
avg_mass_by_species <- penguins %>%
  group_by(species) %>%
  summarise(avg_mass = mean(body_mass_g, na.rm=TRUE)) %>%
  arrange(desc(avg_mass))
avg_mass_by_species

ggplot(avg_mass_by_species,
       aes(x = species, y = avg_mass, fill = species)) + 
  geom_col() +
  labs(title = "Average Body Mass by Penguin Species",
       x = "Species",
       y = "Average Body Mass (g)"
       ) + 
  theme_classic()







