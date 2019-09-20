
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

### Wrap include call to table file

``` r
  
tf <- tempfile(fileext = '.tex')

mtcars%>%
  head()%>%
  knitr::kable(format = 'latex')%>%
  as.character()%>%
  cat(file = tf)

tf%>%
  tex_include()%>%
  captions::wrap_tbl()
#> \begin{table}[!htbp]
#> \caption{caption_01}
#> \label{tbl:tbl01}
#> \include{/tmp/RtmpnYB8di/file24c8718af59c.tex}
#> \end{table}
```
