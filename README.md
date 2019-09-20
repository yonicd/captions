
<!-- README.md is generated from README.Rmd. Please edit that file -->
captions
========

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental) <!-- badges: end -->

The goal of captions is to create Figure and Table environments mechanistically for TeX documents

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(captions)
## basic example code
```

Figures
-------

### Include Figure

``` r
captions::include_fig()
#> \includegraphics[width=0.8\textwidth,page=1]{path_01.pdf}
```

### Wrap Figure

``` r
captions::wrap_fig()
#> \begin{figure}[H]
#> \centering
#> \includegraphics[width=0.8\textwidth,page=1]{path_01.pdf}
#> \caption{caption_01}
#> \label{fig:fig01}
#> \end{figure}
#> \clearpage
#> \newpage
```

``` r
captions::include_fig(FIGPATH = 'mypath.pdf')%>%
  captions::wrap_fig(CAPTION = 'My Caption')
#> \begin{figure}[H]
#> \centering
#> \includegraphics[width=0.8\textwidth,page=1]{mypath.pdf}
#> \caption{My Caption}
#> \label{fig:fig01}
#> \end{figure}
#> \clearpage
#> \newpage
```

### Subfigures

``` r
list(captions::sub_fig(SUBFIGPATH = 'mypath.pdf',SUBLABEL = 'fig:sub1'),
     captions::sub_fig(SUBFIGPATH = 'mypath2.pdf',SUBLABEL = 'fig:sub2')
     )%>%
  captions::wrap_fig(CAPTION = 'My Caption')
#> \begin{figure}[H]
#> \centering
#> \begin{subfigure}[H]{0.7\textwidth}
#> \includegraphics[1\textwidth,page=1]{mypath.pdf}
#> \caption{subcaption_01}
#> \label{fig:sub1}
#> \end{subfigure}
#> \quad
#> \caption{My Caption}
#> \label{fig:fig01}
#> \end{figure}
#> \clearpage
#> \newpage
#> \begin{figure}[H]
#> \centering
#> \begin{subfigure}[H]{0.7\textwidth}
#> \includegraphics[1\textwidth,page=1]{mypath2.pdf}
#> \caption{subcaption_01}
#> \label{fig:sub2}
#> \end{subfigure}
#> \quad
#> \caption{My Caption}
#> \label{fig:fig01}
#> \end{figure}
#> \clearpage
#> \newpage
```

Tables
------

### Wrap tabular lines

``` r
mtcars%>%
  head()%>%
  knitr::kable(format = 'latex')%>%
  captions::wrap_tbl()
#> \begin{table}[!htbp]
#> \caption{caption_01}
#> \label{tbl:tbl01}
#> 
#> \begin{tabular}{l|r|r|r|r|r|r|r|r|r|r|r}
#> \hline
#>   & mpg & cyl & disp & hp & drat & wt & qsec & vs & am & gear & carb\\
#> \hline
#> Mazda RX4 & 21.0 & 6 & 160 & 110 & 3.90 & 2.620 & 16.46 & 0 & 1 & 4 & 4\\
#> \hline
#> Mazda RX4 Wag & 21.0 & 6 & 160 & 110 & 3.90 & 2.875 & 17.02 & 0 & 1 & 4 & 4\\
#> \hline
#> Datsun 710 & 22.8 & 4 & 108 & 93 & 3.85 & 2.320 & 18.61 & 1 & 1 & 4 & 1\\
#> \hline
#> Hornet 4 Drive & 21.4 & 6 & 258 & 110 & 3.08 & 3.215 & 19.44 & 1 & 0 & 3 & 1\\
#> \hline
#> Hornet Sportabout & 18.7 & 8 & 360 & 175 & 3.15 & 3.440 & 17.02 & 0 & 0 & 3 & 2\\
#> \hline
#> Valiant & 18.1 & 6 & 225 & 105 & 2.76 & 3.460 & 20.22 & 1 & 0 & 3 & 1\\
#> \hline
#> \end{tabular}
#> \end{table}
```

Create some files in `tempdir/deliv/table`

``` r
td <- file.path(tempdir(),'deliv/table')
dir.create(td,recursive = TRUE)

tf1 <- file.path(td,'mtcars_head.tex')
file.create(tf1)
#> [1] TRUE

tf2 <- file.path(td,'mtcars_tail.tex')
file.create(tf2)
#> [1] TRUE

mtcars%>%
  head()%>%
  knitr::kable(format = 'latex')%>%
  as.character()%>%
  captions::wrap_tbl()%>%
  cat(file = tf1)

mtcars%>%
  tail()%>%
  knitr::kable(format = 'latex')%>%
  as.character()%>%
  captions::wrap_tbl()%>%
  cat(file = tf2)
```

### Wrap include call to table file

``` r
tf1%>%
  tex_include()%>%
  captions::wrap_tbl()
#> \begin{table}[!htbp]
#> \caption{caption_01}
#> \label{tbl:tbl01}
#> \include{/tmp/RtmpmRllGi/deliv/table/mtcars_head.tex}
#> \end{table}
```

Populate an Output file
-----------------------

``` r


table_file <- file.path(tempdir(),'deliv/tables.tex')

file.create(table_file)
#> [1] TRUE

# Names of the elements in the caption vector is the same as the files in deliv/table

caption <- c(
  mtcars_head = 'First 5 Rows of mtcars',
  mtcars_tail = 'Last 5 Rows of mtcars'
  )

captions::tex_update(
  tex = captions::tex_tables(caption,table_files_dir = td),
  file = table_file,
  section = 'Example',
  type = 'Tables',
  overwrite = TRUE)
#> Warning in captions::tex_update(tex = captions::tex_tables(caption,
#> table_files_dir = td), : Comment Blocks "Example Tables" not found
```

``` r
cat(readLines(table_file),sep = '\n')
#> 
#> %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#> %%             Example Tables Start             %%
#> %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#> \begin{table}[!htbp]
#> \caption{First 5 Rows of mtcars}
#> \label{tbl:efficacy_mtcars_head}
#> \include{/tmp/RtmpmRllGi/deliv/table/mtcars_head.tex}
#> \end{table}
#> \begin{table}[!htbp]
#> \caption{Last 5 Rows of mtcars}
#> \label{tbl:efficacy_mtcars_tail}
#> \include{/tmp/RtmpmRllGi/deliv/table/mtcars_tail.tex}
#> \end{table}
#> %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#> %%              Example Tables End              %%
#> %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```
