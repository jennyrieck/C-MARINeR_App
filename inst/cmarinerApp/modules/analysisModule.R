analysisModule = function(input,output,session,data){
  analysisResults = eventReactive(input$run_analysis,{
    print('i analyze')
    array = data()$array
    covstatis(cov_matrices=array,matrix_norm_type=input$norm_type)
  })

  return(analysisResults)
}


analysisUI = function(id){
  ns = NS(id)
  tagList(
    selectInput(ns('norm_type'), 'Select Norming Type', c('SS1', 'MFA','none'), selected = 'MFA', multiple = FALSE, selectize = TRUE),
    actionButton(ns('run_analysis'), 'Run covSTATIS')
  )


}
