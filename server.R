

library(shiny)


shinyServer(function(input, output) {
  
  #Payment variables
 monthPay <- reactive({
    input$sliderPrincipal*1000*(input$sliderRate/1200)*
      (1+(input$sliderRate/1200))^(input$sliderTerm*12)/
      ((1+(input$sliderRate/1200))^(input$sliderTerm*12)-1)
  })
overallRepayment<- reactive({monthPay()*input$sliderTerm*12})
interestPay<- reactive({monthPay()*input$sliderTerm*12-(input$sliderPrincipal*1000)})
principalRepayment<- reactive({input$sliderPrincipal*1000})
today <- Sys.Date()
year <- as.numeric(format(today,'%Y'))
#UK house data model
houseData<-data.frame("Year"=1975:2017,"Price"=c(10846,11866,12804,15261,19830,23288,23954,24850,27623,31076,34378,37627,43164,51405,61514,57683,54626,51816,51211,51633,51245,53394,59199,65201,71122,80366,88799,106407,127246,148354,156325,166470,181364,168973,156512,165483,162379,162722,185620,186662,192772,208695,209971))
model <- lm(Price~Year,data=houseData)
#model prediction by being reactive to input
modelpred <- reactive({
  yearInput <- input$sliderTerm + year
  predict(model, newdata = data.frame(Year = yearInput))
})


#outputs
# define Monthly payment
  output$mthPay <- renderText({
    monthPay()
  })
  #define all Interest 
 output$interest <- renderText({
  interestPay()
  })

 #define Overall Repayment
 output$overall <- renderText({
   overallRepayment()
 })
 #define Model prediction
 output$predict <- renderText({
   modelpred()
 })
 #define term of Loan Year
 output$yearTerm <- renderText({
   input$sliderTerm + year
 })
 
 #House prices plot
 output$plot1 <- renderPlot({

  plot(houseData$Year,houseData$Price, xlab = "Year", 
        ylab = "House Prices (GBP)", bty = "n", pch = 16,xaxt="n")
   axis(1, at = seq(1975, 2020, by = 5), las=2)
  
   })
 
 })
  
