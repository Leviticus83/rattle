#' Perform the required operations for displaying a pairs plot.
#' 
#' Time-stamp: <2016-09-19 15:58:14 Graham Williams>
#' 
executePairsPlotSelect2 <- function(dataset, vars, target, targets, stratify, sampling, pmax)
{
  startLog(Rtxt("Display a pairs plot for the selected variables."))

  varsi <- getVariableIndicies(vars)
  
 # v1 <- theWidget("pairs_color_combobox")$getActiveText()
  v1 <- target
  if (is.null(v1) || v1 == " ")
  {
    colorStr<-'' # No color selected.
  }
  else
  {
    colorStr<-sprintf('mapping=ggplot2::aes(colour=%s, alpha=0.5),',v1)
  }

  plot.cmd <- paste0(dataset, ' %>%\n',
                     '  dplyr::mutate(', v1, '=as.factor(', v1, ')) %>%\n',
                     '  GGally::ggpairs(columns=c(',
                     paste(varsi, collapse=','), '),\n', 
                     if (colorStr!="") paste0('        ', colorStr, "\n"),
                     '                diag=list(continuous="density",\n',
                     '                          discrete="bar"),\n',
                     '                upper=list(continuous="cor",\n',
                     '                           combo="box",\n',
                     '                           discrete="ratio"),\n',
                     '                lower=list(continuous="points",\n',
                     '                           combo="denstrip",\n',
                     '                           discrete="facetbar"))',
                     ' +\n  ggplot2::theme(panel.grid.major=ggplot2::element_blank())')
  # When this next blank theme is included we get bad plots???? Some
  # problem with colour.
  #
  #                         '         panel.grid.minor=ggplot2::element_blank())')
      
  appendLog(Rtxt("Use GGally's ggpairs() to do the hard work."), plot.cmd)
  newPlot()
  eval(parse(text=sprintf("suppressMessages(print(%s))", plot.cmd)))
}
