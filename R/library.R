#' Create Rstudio project library
#'
#' Creates project library directory \code{lib} inside specified \code{path}.
#'
#' If there is no .Rproj file inside specified \code{path} then error will be
#' thown.
#'
#' If there is no .Rprofile file inside \code{path} then it will be created there
#' and activation command for project specific library will be written to it.
#' Otherwise activation command for project specific library will be appended to
#' the end of existing .Rprofile file.
#'
#' If there is no \code{lib} directory inside \code{path} then directory will be created,
#' otherwise existing directory will be used as library with warning.
#'
#' @param path Character vector specifying path. May contain '.' for parent
#'  directory reference.
#' @param lib Character vector specifying library directory name.
#'
#' @export
use_project_lib <- function(path = '.', lib = 'library'){
  if(any(grepl('.+.Rproj', dir(path)))){
    profileName <- file.path(path, '.Rprofile')
    profileCommand <- sprintf(".libPaths(c(normalizePath(file.path('.', '%s')), .libPaths()))", lib)
    if(file.exists(profileName)){
      content <- readLines(profileName)
      if(any(profileCommand %in% chartr("\"", "'", content))){
        stop(sprintf('There is already "%s" command in "%s" file', profileCommand,
                     normalizePath(profileName)))
      }
      writeLines(c(content, paste0('\n', profileCommand)), profileName)
    } else {
      file.create(profileName)
      writeLines(profileCommand, profileName)
    }
    if(!dir.create(file.path(path, lib), showWarnings = FALSE)){
      warning(sprintf('Existing directory "%s" set as library directory',
                      normalizePath(file.path(path, lib))))
    }
  } else {
    stop(sprintf('There is no .Rproj Rstudio project file in "%s" directory',
                 normalizePath(path, mustWork = TRUE)))
  }
  return(invisible(NULL))
}
