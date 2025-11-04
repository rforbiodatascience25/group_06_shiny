# Loading libraries
library("shiny")
library("bslib")
library("DT")

# Sourcing the functions:
source(file = "app_functions.R")

# Define the Server (Backend)
server <- function(input, output) {
  output$dna <- renderText({
    gene_dna(length = input$n_bases, base_probs = c(input$prob_A, input$prob_T, input$prob_C, input$prob_G))
  })
  
  output$rna <- renderText({
    transcribe_dna(input$dna_to_rna_string)
  })
  
  output$protein <- renderText({
    translate_rna(input$rna_to_protein)
  })
  
  output$base_counted <- DT::renderDT({
    base_freqs(input$base_count)
  })
}
