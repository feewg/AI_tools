---
name: r4ds
description: R 数据科学（R4DS 2e）结构化技能，覆盖可视化、转换、导入、编程与沟通；包含分册参考与章节级可运行 R 示例。
---

# R4DS Skill

## 目标

基于 R for Data Science (2e) 建立可检索、可执行、可复用的知识结构。优先提供“概念 + 函数 + 代码 + 场景”的一体化回答。

## 触发场景

- 请求按章节/主题解释 tidyverse 数据科学方法。
- 请求提供可运行 R 代码示例（数据清洗、可视化、导入、迭代、Quarto）。
- 请求将 R4DS 主题映射到实际业务问题（报表、监控、探索分析、自动化文档）。

## 使用流程

1. 先判定问题所在模块（Whole game / Visualize / Transform / Import / Program / Communicate）。
2. 再定位对应参考文件，提取目标章节的核心概念与关键函数。
3. 优先复用 scripts/ 里的章节脚本作为起点，再按用户数据结构改写。
4. 输出时保持“解释 + 代码 + 注意事项 + 下一步验证”结构。

## 参考文件导航

- `references/part01-whole-game.md`：第1-8章。
- `references/part02-visualize.md`：第9-11章。
- `references/part03-transform.md`：第12-19章。
- `references/part04-import.md`：第20-24章。
- `references/part05-program.md`：第25-27章。
- `references/part06-communicate.md`：第28-29章。

## 脚本资源说明

`scripts/` 目录包含第 1~29 章对应示例脚本。调用时优先：

- 先最小运行，确认依赖与输入。
- 再替换数据源、字段名与图形标签。
- 最后补充异常值、缺失值和边界条件处理。
