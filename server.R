# server.R

library(shiny)
library(ggplot2) # For plotting

server <- function(input, output, session) {
  
  # Reactive expression to get the selected dataset
  selected_dataset <- reactive({
    get(input$dataset_name)
  })
  
  # Dynamically generate the variable selector based on the chosen dataset
  output$variable_selector <- renderUI({
    req(input$dataset_name) # Ensure a dataset is selected
    current_dataset <- selected_dataset()
    numeric_vars <- names(current_dataset)[sapply(current_dataset, is.numeric)]
    selectInput("selected_variable",
                "Choose a numeric variable:",
                choices = numeric_vars)
  })
  
  # Generate the histogram plot
  output$histogram_plot <- renderPlot({
    req(input$selected_variable) # Ensure a variable is selected
    data <- selected_dataset()
    variable_to_plot <- data[[input$selected_variable]]
    
    # Ensure the variable has numeric values
    if (!is.numeric(variable_to_plot)) {
      return(NULL) # Don't plot if not numeric
    }
    
    # Generate the bins based on input$bins from ui.R
    x    <- variable_to_plot
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = 'skyblue', border = 'white',
         xlab = paste("Value of", input$selected_variable),
         main = paste("Histogram of", input$selected_variable, "in", input$dataset_name))
  })
}