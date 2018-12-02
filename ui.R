
library(shiny)

# Def
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Monthly Mortgage Payment Calculator"),
  
  # Sidebar with  slider inputs for variables
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderPrincipal", "What is the Loan Amount (in '000s) ?", 0, 1000, value = 0,step=10),
      sliderInput("sliderRate", "What is the Interest Rate (%)?", 0, 15, value = 2,step=0.5),
      sliderInput("sliderTerm", "What is the Term of the Loan (Years) ?", 5, 35, value = 20,step=5),
      h4("Monthly Repayment"),
      textOutput("mthPay"),
      h4("Interest Paid over the Term of the Loan"),
      textOutput("interest"),
      h4("Total Repayment"),
      textOutput("overall"),
      br(),
      h4("INSTRUCTIONS"),
      h5(" - Select data options using sliders."),
      h5(" - The monthly mortgage payment and total repayment calculators adjust accordingly."),
      h5(" - On the right hand side a prediction of the average UK house prices for the year of the end of the loan appears.")
    ),
 
    # Show the Calculations
    mainPanel(
    h3("Average UK House Prices (GBP) since 1975"),
    plotOutput("plot1"),
    h3("Predicted Average UK House Prices (GBP) at End of Term"),
    h4(textOutput("yearTerm")),
    textOutput("predict")
    )
    
  )
))
