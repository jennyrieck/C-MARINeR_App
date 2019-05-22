shinyServer(function(input, output, session) {
  data = callModule(inputModule,id = 'data')
  analysisResults = callModule(analysisModule, id = 'analysis',data = data)
  observe({
    analysisResults()
  })

  callModule(screeModule, id ='scree', analysisResults = analysisResults)
  callModule(compromiseFactorMapModule, id = 'compromiseFactorMap', analysisResults = analysisResults)


  plotOptions = callModule(plotOptionsModule, id = 'plotOptions')

})
