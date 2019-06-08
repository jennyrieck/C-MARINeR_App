compromiseFactorMapUI = function(id){
  ns = NS(id)
  tagList(
    plotly::plotlyOutput(ns('plot'))
  )
}

compromiseFactorMapModule = function(input,output,session,analysisResults){
  output$plot = plotly::renderPlotly({
    clickEvent = plotly::event_data("plotly_click", source = session$ns('covstatis_click'))

    plot_covstatis_plotly(fi = analysisResults()$compromise_component_scores,
                          fis =  simplify2array(analysisResults()$partial_component_scores),
                          clickEvent = clickEvent,
                          source = session$ns('covstatis_click'))
  })

}


# a ggplot can be readily converted into a plotly plot
plot_covstatis_plotly = function(fi,fis,fi.groups=NULL,fis.groups=NULL,axes=c(1,2), clickEvent = NULL,#, display.fi.names=T,display.fis.names=F
                                 source = 'A'){
  centerPoints =   fi[,axes]
  centerPoints = as.data.frame(centerPoints)
  colnames(centerPoints) = c('x','y')
  centerPoints$property = rownames(centerPoints)
  centerPoints$indivs = ''

  plot.lims <- apply(apply(fis,axes,function(x){max(abs(x))}),2,max) * 1.1
  xlim = c(-plot.lims[axes[1]],plot.lims[axes[1]])
  ylim = c(-plot.lims[axes[2]],plot.lims[axes[2]])


  # here I turn everything back to a list. which makes the simplify2array call when calling this reduntant
  peripheralPoints = fis[,axes,] %>%
    array2list() %>%
    do.call(rbind,.)

  property = rownames(peripheralPoints)
  if(is.null(property)){
    property = rep(seq_len(dim(fis)[1]),dim(fis)[3])
  }

  peripheralPoints = as.data.frame(peripheralPoints)
  colnames(peripheralPoints)= c('x','y')
  peripheralPoints$property = property
  # wasn't sure what a good name would be for this used indivs for individuals
  indivs = dimnames(fis[,axes,])[[3]] %>% lapply(rep,dim(fis)[1]) %>% unlist
  if(is.null(indivs)){
    indivs = seq_len(dim(fis)[3]) %>% lapply(rep,dim(fis)[1]) %>% unlist
  }

  peripheralPoints$indivs = indivs


  connectingLines = data.frame(x = peripheralPoints$x,
                               y = peripheralPoints$y,
                               xend = centerPoints$x[match(peripheralPoints$property,centerPoints$property)],
                               yend = centerPoints$y[match(peripheralPoints$property,centerPoints$property)],
                               property = peripheralPoints$property)

  # if a clickEvent is present, decide which points to highlight. add transparency to the rest
  centerPoints$color = 'mediumorchid4'
  peripheralPoints$color = 'olivedrab3'
  if(!is.null(clickEvent)){

    # the curve number is determined by the layer order.
    # in my code below, the centerPoints curve is curve 2
    # the line segments are curve 1
    # the peripheral points are curve 0
    # only curves 0 and 2 are clickable
    # plotly is javascript based so indexes start from 0
    # line transparency does not work with plotly. that's why it's transparency is always constant
    if(clickEvent[,'curveNumber'] == 0){
      centerPoints$selected = 0.3 # set a low default transparency
      peripheralPoints$selected = 0.3
      connectingLines$selected = 0.3
      highlightIndiv = peripheralPoints[clickEvent[,'pointNumber']+1,]$indivs
      peripheralPoints$selected[peripheralPoints$indivs == highlightIndiv] = 1
      peripheralPoints$color[peripheralPoints$indivs == highlightIndiv] = 'firebrick4'

    } else if(clickEvent[,'curveNumber'] == 2){
      centerPoints$selected = 0.3
      peripheralPoints$selected = 0.3
      connectingLines$selected = 0.3

      highlightProperty = centerPoints[clickEvent[,'pointNumber']+1,]$property

      centerPoints$selected[centerPoints$property == highlightProperty] = 1
      peripheralPoints$selected[peripheralPoints$property == highlightProperty] = 1
      centerPoints$color[centerPoints$property == highlightProperty] = 'firebrick4'
      peripheralPoints$color[peripheralPoints$property == highlightProperty] = 'firebrick4'

      # connectingLines$selected[connectingLines$property == highlightProperty] = 1
    }
  } else{
    centerPoints$selected = 1
    connectingLines$selected = 1
    peripheralPoints$selected = 1
  }


  p = ggplot(data = NULL, aes(x = x, y = y, text = paste(property,
                                                         indivs,
                                                         paste('X:', round(x,2),'Y:', round(y,2)),
                                                         sep = '\n'),)) +
    geom_point(data = peripheralPoints,color = peripheralPoints$color,alpha = peripheralPoints$selected) +
    geom_segment(data = connectingLines, aes(x = x, y = y ,yend = yend, xend = xend),linetype = 4,alpha = connectingLines$selected) +
    geom_point(data = centerPoints, color = centerPoints$color, alpha = centerPoints$selected, size=2) +
    cowplot::theme_cowplot() +
    geom_hline(yintercept = 0,linetype = 5) +
    geom_vline(xintercept = 0, linetype = 5) + theme(axis.line = element_blank())

  # if(display.fi.names){
  #   p = p + geom_label(data = centerPoints,aes(x=x ,y = y, label = property))
  # }
  # if(display.fis.names){
  #   p = p + geom_label(data = peripheralPoints, aes(x = x, y= y, label = indivs))
  # }

  plotly::ggplotly(p,tooltip = c('text'),source=source)

}
