library(shiny)
shinyServer(
  function(input, output) {
    output$oid1 <- renderPrint({input$id1})
    output$oid2 <- renderPrint({input$id2})
    output$oid3 <- renderPrint({input$id3})
    output$oid4 <- renderPrint(as.numeric({input$id2})+as.numeric({input$id3}))
  }
)