# Part IV: Import（第20-24章）

本分册按章节提供：核心主题、关键概念、主要函数、完整代码示例、应用场景与注意事项。

## 第20章 Spreadsheets

### 核心主题
- 本章聚焦 Spreadsheets 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `read_excel()` | 本章高频函数 |
| `write_xlsx()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)
library(readxl)
library(writexl)

demo <- tibble(id = 1:3, score = c(80, 90, 85))
tmp <- tempfile(fileext = ".xlsx")
write_xlsx(list(scores = demo), tmp)
read_excel(tmp, sheet = "scores")
```

### 实际应用场景
- 在 Excel 与 R 之间交换数据
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part20_spreadsheets.R`

## 第21章 Databases

### 核心主题
- 本章聚焦 Databases 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `dbConnect()` | 本章高频函数 |
| `tbl()` | 本章高频函数 |
| `show_query()` | 本章高频函数 |

### 代码示例
```r
library(DBI)
library(dbplyr)
library(dplyr)

con <- dbConnect(duckdb::duckdb())
copy_to(con, tibble(id = 1:5, v = c(3, 5, 2, 8, 7)), "t_demo", temporary = TRUE)
tbl(con, "t_demo") |>
  filter(v >= 5) |>
  summarize(avg_v = mean(v)) |>
  show_query()
```

### 实际应用场景
- 把计算下推数据库
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part21_databases.R`

## 第22章 Arrow

### 核心主题
- 本章聚焦 Arrow 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `open_dataset()` | 本章高频函数 |
| `write_dataset()` | 本章高频函数 |
| `collect()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)
library(arrow)

tmp_dir <- tempfile(); dir.create(tmp_dir)
tibble(year = c(2024, 2024, 2025), v = c(1, 2, 3)) |>
  write_dataset(tmp_dir, format = "parquet", partitioning = "year")

open_dataset(tmp_dir) |>
  filter(year == 2024) |>
  summarize(total = sum(v)) |>
  collect()
```

### 实际应用场景
- 高效处理列式大数据
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part22_arrow.R`

## 第23章 Hierarchical data

### 核心主题
- 本章聚焦 Hierarchical data 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `unnest_wider()` | 本章高频函数 |
| `unnest_longer()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

x <- tibble(id = 1:2, meta = list(list(city = "SH", level = 1), list(city = "BJ", level = 2)))
x |>
  unnest_wider(meta)
```

### 实际应用场景
- 将嵌套结构拉平
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part23_hierarchical.R`

## 第24章 Web scraping

### 核心主题
- 本章聚焦 Web scraping 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `read_html()` | 本章高频函数 |
| `html_elements()` | 本章高频函数 |
| `html_text2()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)
library(rvest)

html <- minimal_html("<ul><li>A</li><li>B</li></ul>")
tibble(item = html |> html_elements("li") |> html_text2())
```

### 实际应用场景
- 抽取网页结构化信息
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part24_webscraping.R`
