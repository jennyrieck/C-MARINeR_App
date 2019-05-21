analysisModule = function(input,output,session,data){
  analysisResults = reactive({
    array = data()$array
    covstatis(cov_matrices=array,table_norm_type=input$norm_type)
  })

  return(analysisResults)
}


analysisUI = function(id){
  ns = NS(id)
  tagList(
    selectInput(ns('norm_type'), 'Select Norming Type', c('SS1', 'MFA','none'), selected = 'MFA', multiple = FALSE, selectize = TRUE)
  )
}
