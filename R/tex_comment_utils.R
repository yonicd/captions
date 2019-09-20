#' @importFrom glue glue
#' @importFrom purrr map
tex_block <- function(BLOCK, align = 'c', token = '%', maxwidth = 40){
  
  BLOCKS <- strsplit(BLOCK,'\n')[[1]]
  
  pat <- glue::glue('{token}*|^{token}*-*|^{token}*-*{token}*$')
  
  BLOCKS <- gsub(pat,'',BLOCKS)
  BLOCKS <- gsub('\\s{2,}','',BLOCKS)
  BLOCKS <- BLOCKS[nzchar(BLOCKS)]
  BLOCKS <- strwrap(BLOCKS,width = maxwidth)
  mb <- pmax(maxwidth + 10,max(nchar(BLOCKS)))
  
  
  BLOCK_TEXT <- purrr::map(BLOCKS,tex_comment,align = align,mb = mb)%>%paste0(collapse = '\n')
  
  bt <- strrep(token,3)
  dt <- strrep('%',mb-6)
  
  boundary <- glue::glue('{bt}{dt}{bt}') 
  
  
  glue::glue(
    boundary,
    '\n',
    BLOCK_TEXT,
    '\n',
    boundary
  ) 
}

tex_comment <- function(TEX, align = 'c', mb = 1, comment_char = '%'){
  
  if(align=='c'){
    pad_left   <- pmax(floor((mb - (nchar(TEX) + 6))/2),1)
    pad_right  <- pmax(ceiling((mb - (nchar(TEX) + 6))/2),1)
  }
  
  if(align=='l'){
    pad_left   <- 0
    pad_right  <- floor((mb - (nchar(TEX) + 6))/2) + ceiling((mb - (nchar(TEX) + 6))/2)
  }
  
  if(align=='r'){
    pad_left   <- floor((mb - (nchar(TEX) + 6))/2) + ceiling((mb - (nchar(TEX) + 6))/2)
    pad_right  <- 0  
  }
  
  sprintf(
    '%s %s%s%s %s',
    strrep(comment_char,2),
    strrep(' ',pad_left),
    TEX,
    strrep(' ',pad_right),
    strrep(comment_char,2)
  )
}
