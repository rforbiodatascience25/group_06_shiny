# Loading libraries
library("shiny")
library("bslib")
library("DT")
library("stringr")
library("ggplot2")

# Sourcing the functions:
source(file = "app_functions.R")

# Function for plotting:
# Plot base frequencies
plot_base_frequency <- function(dna_sequence){
  
  # Split sequence into nucleotide bases
  bases <- dna_sequence |>
    stringr::str_split(pattern = stringr::boundary("character"), simplify = TRUE) |>
    as.character() |>
    unique()
  
  #  Count frequency of each nucleotide base
  counts <- sapply(bases, function(base) stringr::str_count(string = dna_sequence, pattern =  base)) |>
    as.data.frame()
  
  colnames(counts) <- c("Counts")
  counts[["DNA_Sequence"]] <- rownames(counts)
  
  # Plot nucleotide base frequencies
  base_plot <- counts |>
    ggplot2::ggplot(ggplot2::aes(x = DNA_Sequence, y = Counts, fill = DNA_Sequence)) +
    ggplot2::geom_col() +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position = "none") +
    ggplot2::labs(
      title = "Nucleotide Frequency",
      x = "Nucleotide",
      y = "Count"
    )
  
  return(base_plot)
}




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
  
  output$base_plot <- renderPlot({
    plot_base_frequency(dna_sequence = input$base_count)
  })
}
