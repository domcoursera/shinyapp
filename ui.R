# ui.R

install.packages(c("Rcpp", "shiny"), type = "source", force = TRUE)

library(shiny)

ui <- fluidPage(
  titlePanel("Exploring R Datasets"),
  
  # Documentation Panel
  fluidRow(
    column(12,
           wellPanel(
             h4("Welcome to the Dataset Explorer!"),
             p("This application allows users to select from various built-in R datasets, choose a numeric variable from the selected dataset, and visualize its histogram."),
             p("Follow these steps:"),
             tags$ol(
               tags$li("Select a dataset from the dropdown list on the left."),
               tags$li("Choose a numeric variable from the selected dataset using the second dropdown."),
               tags$li("Adjust the number of bins for the histogram using the slider."),
               tags$li("The histogram will update reactively based on your selections.")
             ),
             p("The source code for this application can be found on {Link: GitHub https://github.com/domcoursera/shinyapp}.")
           )
    )
  ),
  
  sidebarLayout(
    sidebarPanel(
      # Dataset selection input
      selectInput("dataset_name",
                  "Choose a dataset:",
                  choices = c("iris", "mtcars", "faithful")), 
      
      # Variable selection input (will be dynamically updated in server.R)
      uiOutput("variable_selector"),
      
      # Slider for number of bins in histogram
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    mainPanel(
      # Reactive output: Histogram
      plotOutput("histogram_plot")
    )
  )
)
