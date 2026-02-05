# SEM图示绘制技能

使用LaTeX/TikZ绘制结构方程模型(SEM)图示的完整工具集。

## 目录结构

```
sem-diagram/
├── SKILL.md                    # 技能说明文档
├── README.md                   # 本文件
├── scripts/                    # 辅助脚本
│   └── sem_generator.py       # SEM图生成器
├── templates/                  # LaTeX模板
│   ├── sem_template.tex       # 通用SEM模板
│   ├── cfa_template.tex       # CFA模型模板
│   └── longitudinal_template.tex # 纵向模型模板
└── resources/                  # 参考资源
    ├── symbols_reference.md   # 符号参考
    └── model_examples.md      # 模型示例
```

## 快速开始

### 1. 使用Python脚本生成SEM图

```bash
# 生成单因子CFA
python scripts/sem_generator.py --model cfa --indicators 4

# 生成中介模型
python scripts/sem_generator.py --model mediation --x X --m M --y Y

# 生成交叉滞后模型
python scripts/sem_generator.py --model clpm --waves 3

# 生成完整LaTeX文档
python scripts/sem_generator.py --model lgcm --full-doc --output lgcm.tex
```

### 2. 使用LaTeX模板

复制相应的模板文件到你的LaTeX项目中，根据需要修改：

```latex
\documentclass{article}
\usepackage{tikz}
\usetikzlibrary{shapes, arrows.meta, positioning}

% 包含样式定义
\input{templates/sem_template.tex}

\begin{document}
  % 插入SEM图代码
\end{document}
```

### 3. 查阅参考资源

- **符号参考**：`resources/symbols_reference.md` - 查看所有SEM符号和TikZ样式
- **模型示例**：`resources/model_examples.md` - 查看常见模型的代码示例

## 支持的模型类型

### 测量模型
- 单因子CFA
- 多因子CFA
- 二阶因子模型
- 双因子模型

### 结构模型
- 基本SEM
- 中介模型
- 调节模型
- 多重中介

### 纵向模型
- 交叉滞后模型（CLPM）
- 随机截距CLPM（RI-CLPM）
- 潜增长模型（LGCM）
- 潜类别增长模型（LCGA）

### 高级模型
- 多水平SEM（MSEM）
- 动态SEM（DSEM）
- 测量不变性模型

## TikZ样式定义

```latex
% 变量样式
\tikzstyle{latent} = [ellipse, draw, minimum width=2cm, minimum height=1cm]
\tikzstyle{manifest} = [rectangle, draw, minimum width=1.5cm, minimum height=0.8cm]
\tikzstyle{error} = [circle, draw, minimum size=0.6cm]
\tikzstyle{const} = [triangle, draw, minimum size=0.6cm]

% 路径样式
\tikzstyle{reg} = [->, >=stealth]
\tikzstyle{cov} = [<->, >=stealth]
\tikzstyle{fixed} = [->, >=stealth, dashed]
```

## 常见问题

### Q: 如何自定义图形样式？
A: 修改TikZ样式定义，例如：
```latex
\tikzstyle{latent} = [ellipse, draw=red, thick, fill=red!10]
```

### Q: 如何添加路径标签？
A: 使用`node`命令：
```latex
\draw[reg] (X) -- node[above] {$a$} (Y);
```

### Q: 如何调整图形大小？
A: 使用`scale`参数：
```latex
\begin{tikzpicture}[scale=0.8, transform shape]
  % 图形代码
\end{tikzpicture}
```

### Q: 如何编译LaTeX文档？
A: 使用pdflatex、xelatex或lualatex：
```bash
pdflatex document.tex
```

## 最佳实践

1. **保持符号一致性**：同一文档中使用相同的符号系统
2. **添加清晰标注**：重要路径应标注参数名称
3. **使用适当尺寸**：确保图形在论文中清晰可读
4. **遵循排版原则**：潜变量在上/左，观测变量在下/右
5. **提供完整图例**：确保读者理解所有符号含义

## 扩展阅读

- [TikZ官方文档](https://tikz.dev/)
- [Mplus用户指南](https://www.statmodel.com/)
- [lavaan包文档](https://lavaan.ugent.be/)

## 贡献

欢迎提交问题报告和改进建议！

## 许可证

MIT License
