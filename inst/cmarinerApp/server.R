shinyServer(function(input, output, session) {
  data = callModule(inputModule,id = 'data')


  analysisResults = callModule(analysis, id = 'analysis',data = data)

})
