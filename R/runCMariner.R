runCMariner = function(array, design = NULL,...){

  .GlobalEnv$.marinerApp$array = array
  .GlobalEnv$.marinerApp$design = design
  on.exit(rm(.marinerApp, envir=.GlobalEnv))


  appDir = system.file('cmarinerApp',package = 'cMARINeRApp')
  shiny::runApp(appDir,...)
}
