install.packages("BrazilCrime")
library(BrazilCrime)
library(dplyr)

setwd("C://Users//israe//OneDrive//Área de Trabalho//tabelas-DF-no-espelho//tabelas")
getwd()

###Fazendo o dicionario da tabela ----

# Importando dados ----
df <- get_sinesp_vde_data(
  state = "all",
  city = "all",
  year = "all",
  category = "all",
  typology = "all",
  granularity = "month"
)

# Gerando os rotulos das colunas ----

rotulos <- data.frame(rotulos = names(df))

# Gerandos outros ----

siglas_UFs <- df |> distinct(uf) |> arrange(uf)
anos       <- df |> distinct(ano) |> arrange(ano)
categorias <- df |> distinct(categoria) |> arrange(categoria)
eventos    <- df |> distinct(categoria, evento) |> arrange(categoria, evento)

# Criando o Dicionario ----
write_xlsx(
  list(
    "UFs"        = siglas_UFs,
    "Anos"       = anos,
    "Categorias" = categorias,
    "Eventos"    = eventos
  ),
  path = "dicionario_sinesp.xlsx"
)

  
