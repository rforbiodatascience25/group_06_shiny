# Loading libraries
library("shiny")
library("bslib")
library("DT")

# Sourcing the functions:
source(file = "app_functions.R")

# Define the User Interface (Frontend)
ui <- fluidPage(
  
  tags$head(
    tags$style(HTML("
    .section_bigger {
      background-color: #1e90ff;
      color: white;
      font-weight: bold;
      text-align: center;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
      padding: 10px 15px;
    }
  "))
  ),
  
  
  layout_columns(
    column_width = 12,
    card(
      titlePanel("Virtual Central Dogma"),
      style = "background-color: #f0f0f0; padding: 15px;"
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      titlePanel("About"),
      helpText("This app handles each part of the central dogma:\n
               Creates a DNA sequence based on your preferred length and base probabilities,
               Transcribes a DNA sequence into a RNA sequence,
               Translates a RNA sequence into a protein sequence
               and finally gives an overview of the base sequences.")
    )
  ),
  layout_columns(
    col_width = 12,
    card(
      card_header("Virtual Gene Generator", class = "section_bigger"),
      sliderInput(inputId = "n_bases",
                  label = "Number of bases:",
                  min = 1,
                  max = 60,
                  value = 30,
                  width = "100%"),
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        numericInput(inputId = "prob_A",
                     label = "Probability of A",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.1),
        numericInput(inputId = "prob_T",
                     label = "Probability of T",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.1),
        numericInput(inputId = "prob_C",
                     label = "Probability of C",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.1),
        numericInput(inputId = "prob_G",
                     label = "Probability of G",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.1)
      ))),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Resulting DNA sequence"),
      mainPanel(
        verbatimTextOutput(outputId = "dna")
      )
    )
  ), 
  
  ### Transcribing ###
  layout_columns(
    col_width = 12,
    card(
      card_header("Virtual RNA polymerase", class = "section_bigger"),
      textInput(inputId = "dna_to_rna_string",
                label = "Please paste your DNA sequence")
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Resulting RNA sequence"),
      mainPanel(
        verbatimTextOutput(outputId = "rna")
      )
    )
  ),
  
  ### Translating ###
  layout_columns(
    col_width = 12,
    card(
      card_header("Virtual Ribosome"),
      textInput(inputId = "rna_to_protein",
                label = "Please paste your RNA sequence")
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Resulting Protein sequence"),
      mainPanel(
        verbatimTextOutput(outputId = "protein")
      )
    )
  ),
  
  ### Base count ###
  layout_columns(
    col_width = 12,
    card(
      card_header("Simple Base Count"),
      textInput(inputId = "base_count",
                label = "Please paste your DNA sequence")
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Counted bases in DNA sequence"),
      mainPanel(
        dataTableOutput(outputId = "base_counted")
      )
    )
  ),
  
  
)
