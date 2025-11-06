# Loading libraries
library("shiny")
library("bslib")
library("DT")

# Sourcing the functions:
source(file = "app_functions.R")

# Define the User Interface (Frontend)
ui <- fluidPage(
  theme = bs_theme(version = 5, bootswatch = "flatly"),
  
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
    .results_bold {
      background-color: #58728e;
      background-size: 30% auto;
      color: #fff;
      font-weight: bold;
      border-top-left-radius: 5px;
      border-top-right-radius: 5px;
      padding: .4rem .75rem;
    }
    .mono-box{
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      background:#f8f9fa; border:1px solid #dee2e6; border-radius:.5rem;
      padding:.5rem .75rem; display:inline-block; max-width:100%; overflow-x:auto;
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
        col_widths = c(6, 6, 6, 6),
        numericInput(inputId = "prob_A",
                     label = "Probability of A",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.01),
        numericInput(inputId = "prob_T",
                     label = "Probability of T",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.01),
        numericInput(inputId = "prob_C",
                     label = "Probability of C",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.01),
        numericInput(inputId = "prob_G",
                     label = "Probability of G",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.01)
      )
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Resulting DNA sequence", class = "results_bold"),
      div(class = "mono-box", textOutput(outputId = "dna", inline = TRUE))
    )
  ), 
  
  ### Transcribing ###
  layout_columns(
    col_width = 12,
    card(
      card_header("Virtual RNA polymerase", class = "section_bigger"),
      textInput(inputId = "dna_to_rna_string",
                label = "Please paste your DNA sequence", placeholder = "e.g. ATTG...")
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Resulting RNA sequence", class = "results_bold"),
      div(class = "mono-box", textOutput(outputId = "rna", inline = TRUE))
    )
  ),
  
  ### Translating ###
  layout_columns(
    col_width = 12,
    card(
      card_header("Virtual Ribosome", class = "section_bigger"),
      textInput(inputId = "rna_to_protein",
                label = "Please paste your RNA sequence", placeholder = "e.g. AUU...")
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Resulting Protein sequence", class = "results_bold"),
      div(class = "mono-box", textOutput(outputId = "protein", inline = TRUE))
    )
  ),
  
  ### Base count ###
  layout_columns(
    col_width = 12,
    card(
      card_header("Simple Base Count", class = "section_bigger"),
      textInput(inputId = "base_count",
                label = "Please paste your DNA sequence")
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Counted bases in DNA sequence", class = "results_bold"),
      DTOutput(outputId = "base_counted")
    )
  ),
  
  
  ### Plotting ###
  layout_columns(
    col_width = 12,
    card(
      card_header("XXX", class = "section_bigger"),
      textInput(inputId = "DNA_seq_plot",
                label = "Please paste your DNA sequence")
    )
  ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Base frequencies of the DNA sequence", class = "results_bold"),
      plotOutput(outputId = "plot")
    )
  )
  
)
