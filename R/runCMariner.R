runCMariner = function(array = NULL, design = NULL,...){

  # this is the only way that I know to pass arguments into a shiny app.
  # a variable with a set name is created in the global environment. this
  # variable is deleted when execution is finished. May overwrite user data
  # if variable names clash
  .GlobalEnv$.marinerApp$array = array
  .GlobalEnv$.marinerApp$design = design
  on.exit(rm(.marinerApp, envir=.GlobalEnv))


  appDir = system.file('cmarinerApp',package = 'cMARINeRApp')
  shiny::runApp(appDir,...)
}
