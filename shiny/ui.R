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
    h6(tags$a(href = "http://rpubs.com/Syd/capstone", "Report")),    
    h6(tags$a(href = "https://github.com/Syd-/dsscapstone-004", "Github"))  
  ),
  mainPanel(
    h3("The sentence fragment you typed:"),
    verbatimTextOutput("inputString"),
    h3("Predicted text from the fragment:"),
    htmlOutput("predictedText"),
    tags$hr(),
    p("Enter a sentence fragment like 'How are you' into the text box to the left, and click the Predict button.")
  )
))