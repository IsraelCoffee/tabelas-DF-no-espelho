library(BrazilCrime)
library(dplyr)
library(zoo)
library(ggplot2)

# Importando a base de dados

df <- get_sinesp_vde_data(
  state = "all",
  city = "all",
  year = "all",
  category = "all",
  typology = "all",
  granularity = "month"
)

# Feminicio por data -----------------------------------------------------------

fem <- df |>
  filter(uf %in% c("DF", "RJ", "SP", "GO", "BA"),
         ano %in% 2022:2024,
         categoria == "vitimas",
         evento == "Feminicídio")

serie_fem <- fem |>
  group_by(uf, data) |>
  summarise(
    feminicidios = sum(total_vitima, na.rm = TRUE), .groups = "drop")

# Gradico por data
anim <- serie_fem |>
  ggplot(aes(x = data, y = feminicidios, color = uf)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Série histórica mensal de feminicídio na BA, DF, GO, RJ, SP",
    subtitle = "De 01/2022 a 05/2025",
    x = NULL,
    y = "Número de feminicío"
  ) +
  theme_bw()

  # Feminicídio por ano --------------------------------------------------------

fem2 <- df |>
  filter(uf %in% c("DF", "RJ", "SP", "GO", "BA"),
         ano %in% 2015:2024,
         categoria == "vitimas",
         evento == "Feminicídio")

serie_fem2 <- fem2 |>
  group_by(uf, ano) |>
  summarise(feminicidio = sum(total_vitima, na.rm = TRUE), .groups = "drop")

anim2 <- serie_fem2 |>
  ggplot(aes(x = ano, y = feminicidio, color = uf)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = 2015:2024) +
  labs(
    title = "Série histórica anual de feminicídio na BA, DF, GO, RJ, SP",
    x = NULL,
    y = "Número de feminicídios",
    color = "UF"
  ) +
  theme_bw()

# Animando o grafico -----------------------------------------------------------

install.packages(c("ggplot2", "gganimate", "gifski", "gapminder"))
library(ggplot2)
library(gganimate)
library(gapminder)

anim_mensal <- anim +
  transition_reveal(data) +
  ease_aes('linear')

animate(anim_mensal, nframes = 150, fps = 20, width = 700, height = 300)
anim_save(
  "C://Users//israe//OneDrive//Área de Trabalho//tabelas-DF-no-espelho//testes animações//feminicio mensal.gif")

anim_anual <- anim2 +
  transition_reveal(ano) +
  ease_aes('linear')

animate(anim_anual, nframes = 150, fps = 20, width = 700, height = 300)
anim_save(
  "C://Users//israe//OneDrive//Área de Trabalho//tabelas-DF-no-espelho//testes animações//feminicio anual.gif")

