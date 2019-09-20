#' @title Update tex file with table/figure enviornments
#' @description Use script to update figures.tex and tables.tex files in a centralized workflow
#' @param tex character, tex lines to edit in file
#' @param file character, Path of file to edit
#' @param section character, Name of section tex lines that will be part of the tex comment block, Default: 'Efficacy'
#' @param type character, Type of output (Tables or Figures) that will be part of the tex comment block, Default: 'Tables'
#' @param show_only_new logical, return to the console what only new section (useful for testing), Default: FALSE
#' @param overwrite logical, overwrite the file, Default: FALSE
#' @return character
#' @rdname tex_update
#' @export 
#' @importFrom glue glue
tex_update <- function(tex, file, section = 'Efficacy', type = 'Tables', show_only_new = FALSE, overwrite = FALSE){
  
  doc <- readLines(file)
  
  if(!overwrite)
    file <- ''
  
  template <- glue::glue('{section} {type}')
  
  idx <- grep(glue::glue('\\b{template}\\b'),doc)
  
  if(!length(idx)){
    warning(glue::glue('Comment Blocks "{template}" not found'))
    idx <- rep(length(doc),2)
    
  }
  
  if(!length(doc)){
    
    doc1 <- doc2 <- ''
    
  }else{
    
    doc1 <- doc[1 : (idx[1] - 2)]  

    if((idx[2] + 1) < length(doc))
      doc2 <- doc[(idx[2] + 2):length(doc)]  
        
  }
  
  thisdoc <- c(
    tex_block(glue::glue('{template} Start')),
    tex,
    tex_block(glue::glue('{template} End'))
  )
  
  if(show_only_new){
    cat(thisdoc,sep='\n')
  }else{
    cat(c(doc1,thisdoc,doc2),sep = '\n',file = file)    
  }
  
}
