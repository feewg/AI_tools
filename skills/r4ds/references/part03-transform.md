# Part III: Transform（第12-19章）

本分册按章节提供：核心主题、关键概念、主要函数、完整代码示例、应用场景与注意事项。

## 第12章 Logical vectors

### 核心主题
- 本章聚焦 Logical vectors 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `if_else()` | 本章高频函数 |
| `all()` | 本章高频函数 |
| `any()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

x <- tibble(v = c(1, 5, 9, NA))
x |>
  mutate(flag = v > 5, band = if_else(v > 5, "high", "low", missing = "missing"))
```

### 实际应用场景
- 编码业务规则
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part12_logicals.R`

## 第13章 Numbers

### 核心主题
- 本章聚焦 Numbers 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `parse_number()` | 本章高频函数 |
| `cut()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

x <- c("$1,234", "59%", "USD 88")
vals <- parse_number(x)
tibble(raw = x, num = vals, bucket = cut(vals, breaks = c(0, 60, 200, 2000)))
```

### 实际应用场景
- 清洗金额和百分比文本
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part13_numbers.R`

## 第14章 Strings

### 核心主题
- 本章聚焦 Strings 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `str_glue()` | 本章高频函数 |
| `str_detect()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

names <- c("alice", "bob")
tibble(name = str_to_title(names), greet = str_glue("Hello, {name}!"), has_o = str_detect(name, "o"))
```

### 实际应用场景
- 标准化文本字段
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part14_strings.R`

## 第15章 Regular expressions

### 核心主题
- 本章聚焦 Regular expressions 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `str_detect()` | 本章高频函数 |
| `str_extract()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

txt <- c("id: A-102", "id: B-204", "none")
tibble(txt, has_id = str_detect(txt, "[A-Z]-\\d{3}"), id = str_extract(txt, "[A-Z]-\\d{3}"))
```

### 实际应用场景
- 提取日志中的规则编码
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part15_regex.R`

## 第16章 Factors

### 核心主题
- 本章聚焦 Factors 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `factor()` | 本章高频函数 |
| `fct_infreq()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

x <- tibble(cat = c("A", "B", "A", "C", "C", "C", "D"))
ggplot(x, aes(fct_infreq(factor(cat)))) + geom_bar()
```

### 实际应用场景
- 按频次排序分类变量
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part16_factors.R`

## 第17章 Dates and times

### 核心主题
- 本章聚焦 Dates and times 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `ymd_hms()` | 本章高频函数 |
| `hour()` | 本章高频函数 |
| `wday()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)
library(lubridate)

ts <- ymd_hms(c("2025-01-01 08:10:00", "2025-01-01 21:30:00"), tz = "UTC")
tibble(ts, hour = hour(ts), wday = wday(ts, label = TRUE))
```

### 实际应用场景
- 识别时间周期特征
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part17_datetimes.R`

## 第18章 Missing values

### 核心主题
- 本章聚焦 Missing values 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `is.na()` | 本章高频函数 |
| `coalesce()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

df <- tibble(a = c(1, NA, 3), b = c(NA, 2, 3))
df |>
  mutate(miss_a = is.na(a), a_filled = coalesce(a, b))
```

### 实际应用场景
- 设计缺失值处理流程
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part18_missing.R`

## 第19章 Joins

### 核心主题
- 本章聚焦 Joins 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `left_join()` | 本章高频函数 |
| `anti_join()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

orders <- tibble(id = c(1, 2, 3), amount = c(99, 129, 88))
users  <- tibble(id = c(1, 3), tier = c("gold", "silver"))
orders |>
  left_join(users, by = join_by(id))
```

### 实际应用场景
- 关联事实表与维度表
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part19_joins.R`
