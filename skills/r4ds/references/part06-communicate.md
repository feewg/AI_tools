# Part VI: Communicate（第28-29章）

本分册按章节提供：核心主题、关键概念、主要函数、完整代码示例、应用场景与注意事项。

## 第28章 Quarto

### 核心主题
- 本章聚焦 Quarto 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `quarto render` | 本章高频函数 |

### 代码示例
```r
# 在终端执行
# quarto render report.qmd

# 在 report.qmd 中插入 R 代码块后渲染
# ```{r}
# library(tidyverse)
# ggplot(mpg, aes(displ, hwy)) + geom_point()
# ```
```

### 实际应用场景
- 生成可复现分析文档
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part28_quarto.R`

## 第29章 Quarto formats

### 核心主题
- 本章聚焦 Quarto formats 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `quarto::quarto_render()` | 本章高频函数 |

### 代码示例
```r
# R 控制台示例
# quarto::quarto_render("report.qmd", output_format = c("html", "pdf"))

# YAML 示例
# ---
# title: "Project report"
# format: [html, docx]
# ---
```

### 实际应用场景
- 面向不同受众输出多格式文档
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part29_quarto_formats.R`
