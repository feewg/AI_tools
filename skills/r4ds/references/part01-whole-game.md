# Part I: Whole game（第1-8章）

本分册按章节提供：核心主题、关键概念、主要函数、完整代码示例、应用场景与注意事项。

## 第1章 Data visualization

### 核心主题
- 本章聚焦 Data visualization 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `ggplot()` | 本章高频函数 |
| `aes()` | 本章高频函数 |
| `geom_point()` | 本章高频函数 |
| `geom_smooth()` | 本章高频函数 |
| `labs()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)
library(palmerpenguins)

ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(color = species), na.rm = TRUE) +
  geom_smooth(method = "lm", se = FALSE, na.rm = TRUE) +
  labs(x = "Flipper length (mm)", y = "Body mass (g)", color = "Species")
```

### 实际应用场景
- 构建基础散点图并分组解释关系
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part01_visualization.R`

## 第2章 Workflow: basics

### 核心主题
- 本章聚焦 Workflow: basics 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `c()` | 本章高频函数 |
| `mean()` | 本章高频函数 |
| `seq()` | 本章高频函数 |

### 代码示例
```r
nums <- c(2, 4, 6, 8, 10)
avg <- mean(nums)
idx <- seq(1, 10, by = 2)
list(avg = avg, idx = idx)
```

### 实际应用场景
- 建立最小可复现脚本习惯
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part02_workflow_basics.R`

## 第3章 Data transformation

### 核心主题
- 本章聚焦 Data transformation 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `filter()` | 本章高频函数 |
| `select()` | 本章高频函数 |
| `mutate()` | 本章高频函数 |
| `summarize()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)
library(nycflights13)

flights |>
  filter(!is.na(arr_delay)) |>
  group_by(carrier) |>
  summarize(avg_arr_delay = mean(arr_delay), .groups = "drop") |>
  arrange(desc(avg_arr_delay))
```

### 实际应用场景
- 完成行列筛选与分组聚合
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part03_transformation.R`

## 第4章 Workflow: code style

### 核心主题
- 本章聚焦 Workflow: code style 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `filter()` | 本章高频函数 |
| `group_by()` | 本章高频函数 |
| `summarize()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)
library(nycflights13)

delay_summary <- flights |>
  filter(!is.na(arr_delay)) |>
  group_by(origin) |>
  summarize(avg_delay = mean(arr_delay), .groups = "drop")

delay_summary
```

### 实际应用场景
- 统一团队脚本风格
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part04_workflow_style.R`

## 第5章 Data tidying

### 核心主题
- 本章聚焦 Data tidying 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `pivot_longer()` | 本章高频函数 |
| `pivot_wider()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

sales_wide <- tibble(id = c(1, 2), q1 = c(120, 150), q2 = c(130, 165))
sales_long <- sales_wide |>
  pivot_longer(q1:q2, names_to = "quarter", values_to = "revenue")

sales_long |>
  pivot_wider(names_from = quarter, values_from = revenue)
```

### 实际应用场景
- 把报表表格整理为 tidy 结构
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part05_tidying.R`

## 第6章 Workflow: scripts and projects

### 核心主题
- 本章聚焦 Workflow: scripts and projects 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `write_csv()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

out <- tibble(metric = c("a", "b"), value = c(1, 2))
dir.create("output", showWarnings = FALSE)
write_csv(out, "output/summary.csv")
```

### 实际应用场景
- 管理项目输出产物
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part06_workflow_scripts.R`

## 第7章 Data import

### 核心主题
- 本章聚焦 Data import 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `read_csv()` | 本章高频函数 |
| `spec()` | 本章高频函数 |
| `write_csv()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

csv_text <- I("id,name,score\n1,A,88\n2,B,92")
df <- read_csv(csv_text, show_col_types = FALSE)
spec(df)
write_csv(df, tempfile(fileext = ".csv"))
```

### 实际应用场景
- 构建稳定的数据接入层
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part07_import.R`

## 第8章 Workflow: getting help

### 核心主题
- 本章聚焦 Workflow: getting help 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `reprex::reprex()` | 本章高频函数 |

### 代码示例
```r
y <- 1:4
mean(y)
# 需要求助时可把最小示例贴到 reprex::reprex()
```

### 实际应用场景
- 用最小复现示例提问
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part08_workflow_help.R`
