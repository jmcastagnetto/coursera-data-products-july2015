library(shiny)

# Define UI for our height prediction application
shinyUI(fluidPage(

  # Application title
  titlePanel("Predict the height of your child"),

  # Sidebar with a couple of numeric inputs and a radio button
  sidebarLayout(
    sidebarPanel(
      helpText("We will try to predict your child's height,
               using a model that requires the heights (in cm)
               of the father and mother, as well as your child's gender."),
      helpText("Please input the required values below:"),
      numericInput(inputId = "inFh",
                   label = "Father' height (cm.):",
                   value = 175, # average height of fathers
                   min = 150,
                   max = 200,
                   step = 1),
      numericInput(inputId = "inMh",
                   label = "Mother's height (cm.):",
                   value = 162, # average height of mothers
                   min = 150,
                   max = 200,
                   step = 1),
      radioButtons(inputId = "inGen",
                   label = "Child's gender: ",
                   choices = c("Female"="female", "Male"="male"),
                   inline = TRUE)
    ),

    # Show text indicating the values entered
    mainPanel(
      htmlOutput("parentsText"),
      htmlOutput("prediction"),
      plotOutput("barsPlot"),
      plotOutput("pairsPlot")
    )
  )
))
