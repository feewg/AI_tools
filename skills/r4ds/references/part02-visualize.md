# Part II: Visualize（第9-11章）

本分册按章节提供：核心主题、关键概念、主要函数、完整代码示例、应用场景与注意事项。

## 第9章 Layers

### 核心主题
- 本章聚焦 Layers 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `geom_point()` | 本章高频函数 |
| `facet_wrap()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class), alpha = 0.7) +
  facet_wrap(~drv)
```

### 实际应用场景
- 通过图层和分面提升可读性
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part09_layers.R`

## 第10章 Exploratory data analysis

### 核心主题
- 本章聚焦 Exploratory data analysis 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `geom_histogram()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

diamonds |>
  filter(carat < 3) |>
  ggplot(aes(carat)) +
  geom_histogram(binwidth = 0.05)
```

### 实际应用场景
- 探索分布与异常模式
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part10_eda.R`

## 第11章 Communication

### 核心主题
- 本章聚焦 Communication 的关键方法，并强调可复现实现。

### 关键概念
- 先明确问题，再选择合适数据结构与函数。
- 尽量把中间结果保留为可检查对象。
- 代码应可重复执行并便于复用。

### 主要函数/工具
| 函数 | 用途 |
|---|---|
| `labs()` | 本章高频函数 |
| `theme_minimal()` | 本章高频函数 |

### 代码示例
```r
library(tidyverse)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Highway MPG vs displacement", x = "Engine displacement", y = "Highway MPG") +
  theme_minimal()
```

### 实际应用场景
- 把图从可视化提升到可沟通
- 将示例改写到业务字段后可直接集成到分析流程。

### 注意事项
- 先检查缺失值和字段类型，再下结论。
- 对应脚本：`scripts/part11_communication.R`
