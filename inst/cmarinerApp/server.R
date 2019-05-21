shinyServer(function(input, output, session) {
  data = callModule(inputModule,id = 'data')
  analysisResults = callModule(analysisModule, id = 'analysis',data = data)

  plotOptions = callModule(plotOptionsModule, id = 'plotOptions')

})
