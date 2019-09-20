#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param SUBPLACE PARAM_DESCRIPTION, Default: 'H'
#' @param SUBTEXTWIDTH PARAM_DESCRIPTION, Default: 0.7
#' @param SUBFIGWIDTH PARAM_DESCRIPTION, Default: 1
#' @param SUBPAGE PARAM_DESCRIPTION, Default: 1
#' @param SUBFIGPATH PARAM_DESCRIPTION, Default: 'path_01.pdf'
#' @param SUBCAPTION PARAM_DESCRIPTION, Default: 'subcaption_01'
#' @param SUBLABEL PARAM_DESCRIPTION, Default: 'fig:subfig_01'
#' @param SUBFIGSPACE PARAM_DESCRIPTION, Default: 'quad'
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
#' @rdname sub_fig
#' @export 
#' @importFrom glue glue
sub_fig <- function(
  SUBPLACE = 'H',
  SUBTEXTWIDTH = 0.7,
  SUBFIGWIDTH = 1,
  SUBPAGE = 1,
  SUBFIGPATH = 'path_01.pdf',
  SUBCAPTION = 'subcaption_01',
  SUBLABEL = 'fig:subfig_01',
  SUBFIGSPACE = '\\quad'
){
  
  glue::glue(
    '\\begin{{subfigure}}[{SUBPLACE}]{{{SUBTEXTWIDTH}\\textwidth}',
    '\\includegraphics[{SUBFIGWIDTH}\\textwidth,page={SUBPAGE}]{{{SUBFIGPATH}}}',
    '\\caption{{{SUBCAPTION}}}',
    '\\label{{{SUBLABEL}}}',
    '\\end{{subfigure}}',
    '{SUBFIGSPACE}',
    .sep='\n')
  
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param SUBFIGS PARAM_DESCRIPTION, Default: include_fig()
#' @param PLACE PARAM_DESCRIPTION, Default: 'H'
#' @param CAPTION PARAM_DESCRIPTION, Default: 'caption_01'
#' @param LABEL PARAM_DESCRIPTION, Default: 'fig:fig01'
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
#' @rdname wrap_fig
#' @export 
#' @importFrom glue glue
wrap_fig <- function( SUBFIGS = include_fig(), PLACE = 'H', CAPTION = 'caption_01', LABEL = 'fig:fig01'){
  
  glue::glue(
    '\\begin{{figure}}[{PLACE}]',
    '\\centering',
    '{SUBFIGS}',
    '\\caption{{{CAPTION}}}',
    '\\label{{{LABEL}}}',
    '\\end{{figure}}',
    '\\clearpage',
    '\\newpage',
    .sep = '\n')
  
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param FIGPATH PARAM_DESCRIPTION, Default: 'path_01.pdf'
#' @param WIDTH PARAM_DESCRIPTION, Default: 0.8
#' @param PAGE PARAM_DESCRIPTION, Default: 1
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
#' @rdname include_fig
#' @export 
#' @importFrom glue glue
include_fig <- function( FIGPATH = 'path_01.pdf', WIDTH = 0.8, PAGE = 1){
  
  glue::glue('\\includegraphics[width={WIDTH}\\textwidth,page={PAGE}]{{{FIGPATH}}}')
  
}
