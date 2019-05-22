screeUI = function(id){
  ns = NS(id)
  tagList(
    plotOutput(ns('plot'))
  )
}

screeModule = function(input,output,session,analysisResults){
  output$plot = renderPlot({
    print('i am plotted')
    par(mar=c(5, 5, 4, 5) + 0.1)
    plot((analysisResults()$compromise_eigen$values/sum(analysisResults()$compromise_eigen$values)*100),type = 'l', xlab='Component', ylab='',main='Compromise Scree Plot', axes=F)
    box()
    axis(2,at= (analysisResults()$compromise_eigen$values/sum(analysisResults()$compromise_eigen$values)*100),labels=round(analysisResults()$compromise_eigen$values/sum(analysisResults()$compromise_eigen$values)*100,1),las=2,cex.axis=.65)
    mtext("Explained Variance",2,line=3)
    axis(4,at= (analysisResults()$compromise_eigen$values/sum(analysisResults()$compromise_eigen$values)*100),labels=round(analysisResults()$compromise_eigen$values,2),las=2,cex.axis=.65)
    mtext("eigen Value",4,line=3)
    axis(1,at=1:length(analysisResults()$compromise_eigen$values),lwd=1)
          })
}
