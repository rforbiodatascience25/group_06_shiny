# Loading libraries
library("shiny")
library("bslib")
library("DT")

# Sourcing the functions:
source(file = "app_functions.R")

# Sourcing the ui:
source(file = "ui.R")

# Source the server:
source(file = "server.R")

# Launch the shiny app
shinyApp(ui = ui, server = server)
