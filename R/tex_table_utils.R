#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param TABLE PARAM_DESCRIPTION
#' @param CAPTION PARAM_DESCRIPTION, Default: 'caption_01'
#' @param LABEL PARAM_DESCRIPTION, Default: 'tbl:tbl01'
#' @param PLACE PARAM_DESCRIPTION, Default: '!htbp'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[glue]{glue}}
#' @rdname wrap_tbl
#' @export 
#' @importFrom glue glue
wrap_tbl <- function(TABLE, CAPTION='caption_01', LABEL='tbl:tbl01', PLACE = "!htbp") {
  
  glue::glue("\\begin{{table}}[{PLACE}]",
             "\\caption{{{CAPTION}}}",
             "\\label{{{LABEL}}}",
             "{paste0(TABLE,collapse = '\n')}",
             "\\end{{table}}",.sep = '\n'
            )

}

#' @title Generate an include call for tex
#' @description wraps include around a path for tex
#' @param path character, path to file
#' @return character
#' @rdname tex_include
#' @export 
#' @importFrom glue glue
tex_include <- function(path){
  glue::glue('\\include{{{normalizePath(path)}}}')
}
