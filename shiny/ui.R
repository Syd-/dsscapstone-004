library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("A simple text prediction app"),
  sidebarPanel(
    tags$script(HTML("function addThis(what) {
      $('#search').val($('#search').val() + ' ' + what.value);
      $('#search').trigger('change');
    }")),
    textInput("search", label = h6("Please enter words below:")),
    actionButton("predictButton", "Predict"),
    tags$hr(),
    h4("Sid M"),
    tags$hr(),
    h6("Links"),
    h6(tags$a(href = "https://github.com/Syd-/devdataprod-014-code", "Report")),    
    h6(tags$a(href = "https://github.com/Syd-/devdataprod-014-code", "Github"))  
  ),
  mainPanel(
    h3("The sentence fragment you typed:"),
    verbatimTextOutput("inputString"),
    h3("Predicted text from the fragment:"),
    htmlOutput("predictedText")
  )
))