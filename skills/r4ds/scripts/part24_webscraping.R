# Chapter 24: Web scraping

library(tidyverse)
library(rvest)

html <- minimal_html("<ul><li>A</li><li>B</li></ul>")
tibble(item = html |> html_elements("li") |> html_text2())
