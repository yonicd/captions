#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param captions character, Named character vector. Names are the same as the figure filenames in deliv/table and the value is the caption
#' @param table_files_dir character, path to location of the analysis tables directory in deliv, Default: 'table'
#' @param analysis character, Name of the analysis to place in the tex comment block, Default: 'efficacy'
#' @param only_tex logical, return tibble or only the tex as character vector, Default: TRUE
#' @return character/tibble depending on only_tex
#' @return charater
#' @rdname tex_tables
#' @export 
#' @importFrom tibble enframe tibble
#' @importFrom dplyr left_join mutate
#' @importFrom tools file_path_sans_ext
#' @importFrom purrr pmap_chr
#' @importFrom glue glue
#' @importFrom rlang sym !!
tex_tables <- function(captions, table_files_dir = '../deliv/table',analysis = 'efficacy',only_tex = TRUE){
  
  tbl <- tibble::enframe(captions,name = 'stem',value = 'caption')%>%
  dplyr::left_join(
    tibble::tibble(
      file = list.files(table_files_dir,pattern = '.tex$'),
      stem = tools::file_path_sans_ext(file),
      path = file.path(table_files_dir,file)
    ), by='stem')%>%
  dplyr::mutate(
    tex = purrr::pmap_chr(list(file = !!rlang::sym('path'),stem = !!rlang::sym('stem'),caption = !!rlang::sym('caption')),
                          .f=function(file,stem,caption,analysis){
                            
                            wrap_tbl(TABLE = tex_include(file),
                                     LABEL = glue::glue('tbl:{analysis}_{stem}'),
                                     CAPTION = caption)
                            
                          },analysis = analysis)
  )
  
  if(only_tex){
    tbl$tex  
  }else{
    tbl
  }
  
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param captions character, Named character vector. Names are the same as the figure filenames in deliv/table and the value is the caption
#' @param figure_files_dir character, Path to location of the analysis figures directory in deliv, Default: 'figure'
#' @param analysis character, Name of the analysis to place in the tex comment block, Default: 'efficacy'
#' @param only_tex logical, return tibble or only the tex as character vector, Default: TRUE
#' @return character/tibble depending on only_tex
#' @rdname tex_figures
#' @export 
#' @importFrom tibble enframe tibble
#' @importFrom dplyr left_join mutate
#' @importFrom tools file_path_sans_ext
#' @importFrom purrr pmap_chr
#' @importFrom glue glue
#' @importFrom rlang sym !!
tex_figures <- function(captions,figure_files_dir = '../deliv/figure',analysis = 'efficacy', only_tex = TRUE){
  
  tbl <- tibble::enframe(captions,name = 'stem',value = 'caption')%>%
    dplyr::left_join(
      tibble::tibble(
        file = list.files(file.path('../deliv',figure_files_dir)),
        stem = tools::file_path_sans_ext(file),
        path = file.path(figure_files_dir,'..',file)
      ), by='stem')%>%
    dplyr::mutate(
      tex = purrr::pmap_chr(list(file = !!rlang::sym('path'),stem = !!rlang::sym('stem'),caption = !!rlang::sym('caption')),
                            .f=function(file,stem,caption,analysis){
                              file%>%
                                include_fig()%>%
                                wrap_fig(LABEL = glue::glue('fig:{analysis}_{stem}'),
                                         CAPTION = caption)
                              
                            },analysis = analysis)
    )
  
  if(only_tex){
    tbl$tex  
  }else{
    tbl
  }
  
}
