library(shiny)

bigram <<- readRDS("nBigram.RData")
trigram <<- readRDS("nTrigram.RData")
tetragram <<- readRDS("nTetragram.RData")

predict <- function(search, tetragram, trigram, bigram) {
  predicted <- c()
  search <- clean(search)
  for (i in length(search):1) {
    if (i == 3) {
      predicted <- as.character(tetragram[grep(paste(tail(search, 3), collapse = " "), tetragram$search), ]$predict)
    }
    if (i == 2 && length(predicted) < 1) {
      predicted <- c(predicted, head(as.character(trigram[grep(paste(tail(search, 2), collapse = " "), trigram$search), ]$predict), 2))
    }
    if (i == 1 && length(predicted) < 1) {
      predicted <- c(predicted, head(as.character(bigram[grep(paste(tail(search, 1), collapse = " "), bigram$search), ]$predict), 2))
    }
  }
  return(predicted)
}

clean <- function(string) {
  string <- gsub("[^a-zA-Z#!?;. ]", "", string)
  string <- gsub("#[a-zA-Z]*", "", string)
  string <- gsub("[!?;]", ".", string)
  string <- sub("^.*[.](.*)", "\\1", string)
  string <- tolower(string)
  string <- tail(strsplit(string, " ")[[1]], 3)
  return(string)
}

shinyServer(
  function (input, output) {
    searchText <- eventReactive(input$predictButton, {
      input$search
    })    
    
    output$inputString <- renderText(searchText())
    output$predictedText <- renderText({
      ret <- predict(searchText(), bigram, trigram, tetragram)
      if (length(ret) == 0) {
        ret <- "NO MATCHES FOUND"
      }
      else {
        for (i in 1:length(ret)) {
          ret[i] <- paste(
            "<input type='button' value='",
            ret[i],
            "' onclick='addThis(this);'>",
            sep = "")
        }
      }
      ret
    })
  }
)