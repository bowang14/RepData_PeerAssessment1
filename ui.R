library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Cake Scoring"),
  sidebarPanel(
    selectInput("id1", "Select a cake",
                       c("cake 1" = "cake 1",
                         "cake 2" = "cake 2",
                         "cake 3" = "cake 3")),
    h3('Score'),
    numericInput('id2', 'Appearence', 0, min = 0, max = 5, step = 1),
    numericInput('id3', 'Taste', 0, min = 0, max = 5, step = 1),
    h4('Documentation'),
    helpText("This app is to give your scores to 3 cakes which are Cake 1, Cake 2 and Cake 3. There are 3 cakes you can select to give your score. You may give your score from 0 to 5 points for apperance and taste respectively. And then the app will calculate the total score automatically.")
  ),
  mainPanel(
    h2('Scoring Results'),
    h3('Your Cake'),
    verbatimTextOutput("oid1"),
    h4('Your Score'),
    h4('Appearence'),
    verbatimTextOutput("oid2"),
    h4('Taste'),
    verbatimTextOutput("oid3"),
    h4('Total Score'),
    verbatimTextOutput("oid4")
  )
))
