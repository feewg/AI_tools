---
name: sem-diagram
description: 使用LaTeX/TikZ绘制结构方程模型(SEM)图示，包括CFA、中介模型、交叉滞后模型等常见SEM结构的可视化
metadata:
  short-description: SEM图示绘制指南 - LaTeX/TikZ语法规范与预制块
---

# SEM 图示通用规范（LaTeX / TikZ）

Structural Equation Modeling – Visual Grammar & Prefab Blocks

## When to Use This Skill

当用户需要：
- 使用LaTeX/TikZ绘制结构方程模型(SEM)图示
- 创建CFA（验证性因子分析）图
- 绘制中介模型、调节模型
- 制作交叉滞后模型（CLPM）或潜增长模型（LGCM）
- 确保SEM图符合学术出版规范

---

## SEM 图的"语法规则"（Visual Grammar）

SEM图是一套约定俗成的图形语言。每种形状代表特定变量，每种线代表特定统计含义。

---

## 变量类型与图形表示

### 潜变量（Latent Variable）
- **图形**：椭圆（Ellipse）
- **含义**：不可直接观测的构念/因子
- **常见记号**：
  - 一般SEM：`η`（内生）、`ξ`（外生）
  - CFA/心理测量：`F1`, `F2`
  - 增长模型：`i`（截距）、`s`（斜率）
- **TikZ样式**：`latent`

```latex
\tikzstyle{latent} = [ellipse, draw, minimum width=2cm, minimum height=1cm]
```

### 观测变量（Observed / Manifest Variable）
- **图形**：矩形（Rectangle）
- **含义**：题项、指标、测量值
- **常见记号**：
  - 连续指标：`y1`, `y2`
  - 问卷题项：`item1`
  - 时间序列：`y_t`
- **TikZ样式**：`manifest`

```latex
\tikzstyle{manifest} = [rectangle, draw, minimum width=1.5cm, minimum height=0.8cm]
```

### 误差 / 残差 / 扰动项
- **图形**：小圆（Circle）
- **类型区分**：
  - 指标测量误差：`ε` (epsilon)
  - 内生潜变量扰动：`ζ` (zeta)
- **语义**：未被模型解释的变异
- **TikZ样式**：`error`

```latex
\tikzstyle{error} = [circle, draw, minimum size=0.6cm]
```

### 常数 / 截距 / 均值结构
- **图形**：三角形 或 标注为 `1`
- **含义**：
  - 均值结构（Mean structure）
  - 截距（Intercept）
- **TikZ样式**：`const`

```latex
\tikzstyle{const} = [triangle, draw, minimum size=0.6cm]
```

---

## 路径类型与统计含义

### 单向箭头 `A → B`
- **含义**：
  - 回归路径（Regression）
  - 因子载荷（Factor loading）
  - 自回归路径（Lagged effect）
- **使用场景**：
  - 潜变量 → 指标
  - 自变量 → 因变量
- **TikZ样式**：`reg`

```latex
\tikzstyle{reg} = [->, >=stealth]
```

### 双向箭头 `A ↔ B`
- **含义**：
  - 协方差/相关
- **使用场景**：
  - 外生变量之间
  - 误差项相关（Correlated residuals）
- **TikZ样式**：`cov`

```latex
\tikzstyle{cov} = [<->, >=stealth]
```

### 自回路 `A ↔ A`
- **含义**：方差（Variance）
- **实践中**：
  - 常被"误差圆 → 变量"替代
  - 语义更清晰：**残差导致变量的未解释部分**

### 虚线路径
- **含义（约定）**：
  - 固定参数（fixed）
  - 约束参数（equality constraint）
- ⚠️ **注意**：图中虚线只是"标记"，真正固定必须在模型语法（如Mplus）中完成。

```latex
\tikzstyle{fixed} = [->, >=stealth, dashed]
```

---

## SEM 图的一般排版原则（Layout）

- **测量模型（CFA）**
  - 潜变量在上
  - 指标在下
- **结构模型（SEM）**
  - 外生变量在左
  - 内生变量在右
- **中介模型**
  - 中介变量居中
- **纵向模型**
  - 时间从左 → 右 或 上 → 下
- **误差项**
  - 放在对应变量旁边
- **协方差**
  - 使用 `bend left/right` 避免线条交叉

---

## SEM 预制块（Prefab Blocks）

### 5.1 单因子 CFA（Single-Factor CFA）
**结构**：
- 一个潜变量 → 多个指标
- 每个指标一个测量误差

**用途**：
- 信度与结构效度检验
- 问卷验证

```latex
% 单因子CFA示例
\begin{tikzpicture}
  \node[latent] (F1) at (0,2) {$F_1$};
  \node[manifest] (y1) at (-2,0) {$y_1$};
  \node[manifest] (y2) at (0,0) {$y_2$};
  \node[manifest] (y3) at (2,0) {$y_3$};
  
  \node[error] (e1) at (-2,-1) {$\varepsilon_1$};
  \node[error] (e2) at (0,-1) {$\varepsilon_2$};
  \node[error] (e3) at (2,-1) {$\varepsilon_3$};
  
  \draw[reg] (F1) -- (y1);
  \draw[reg] (F1) -- (y2);
  \draw[reg] (F1) -- (y3);
  
  \draw[reg] (e1) -- (y1);
  \draw[reg] (e2) -- (y2);
  \draw[reg] (e3) -- (y3);
\end{tikzpicture}
```

### 5.2 多因子 CFA（Multi-Factor CFA）
**结构**：
- 多个潜变量
- 各自加载到不同指标
- 潜变量之间允许协方差

**用途**：
- 区分效度
- 构念结构验证

### 5.3 二阶因子模型（Second-Order Factor）
**结构**：
- 二阶潜变量 → 一阶潜变量 → 指标

**用途**：
- 总因子 + 子维度
- 人格、能力结构

### 5.4 双因子模型（Bifactor Model）
**结构**：
- 一个General factor
- 多个Specific factors
- 指标同时加载在General + Specific

**用途**：
- 方法效应
- 一般因子 vs 特异因子

### 5.5 结构回归模型（Basic SEM）
**结构**：
- 外生潜变量 → 内生潜变量
- 内生潜变量有扰动项 ζ

**用途**：
- 理论路径检验
- 假设驱动研究

```latex
% 基本SEM示例
\begin{tikzpicture}
  % 外生潜变量
  \node[latent] (xi1) at (0,2) {$\xi_1$};
  \node[latent] (xi2) at (3,2) {$\xi_2$};
  
  % 内生潜变量
  \node[latent] (eta1) at (1.5,0) {$\eta_1$};
  
  % 扰动项
  \node[error] (zeta1) at (1.5,-1.5) {$\zeta_1$};
  
  % 路径
  \draw[reg] (xi1) -- (eta1);
  \draw[reg] (xi2) -- (eta1);
  \draw[reg] (zeta1) -- (eta1);
  \draw[cov] (xi1) -- (xi2);
\end{tikzpicture}
```

### 5.6 中介模型（Mediation）
**结构**：
- X → M → Y
- 可包含 X → Y 直接路径

**用途**：
- 机制分析
- 间接效应检验

```latex
% 中介模型示例
\begin{tikzpicture}
  \node[latent] (X) at (0,1) {$X$};
  \node[latent] (M) at (3,1) {$M$};
  \node[latent] (Y) at (6,1) {$Y$};
  
  \draw[reg] (X) -- node[above] {$a$} (M);
  \draw[reg] (M) -- node[above] {$b$} (Y);
  \draw[reg, bend left] (X) to node[above] {$c'$} (Y);
\end{tikzpicture}
```

### 5.7 多重中介模型（Parallel / Serial）
**结构**：
- 并联中介：X → M1, M2 → Y
- 串联中介：X → M1 → M2 → Y

### 5.8 调节模型（Moderation / Interaction）
**结构**：
- X, Z → Y
- 或使用潜变量交互项 X×Z → Y

### 5.9 交叉滞后模型（CLPM）
**结构**：
- Y_t → Y_{t+1}
- X_t → Y_{t+1}
- 同时点残差相关

**用途**：
- 纵向因果推断

```latex
% CLPM示例（两波次）
\begin{tikzpicture}
  % T1
  \node[latent] (X1) at (0,2) {$X_1$};
  \node[latent] (Y1) at (3,2) {$Y_1$};
  
  % T2
  \node[latent] (X2) at (0,0) {$X_2$};
  \node[latent] (Y2) at (3,0) {$Y_2$};
  
  % 自回归
  \draw[reg] (X1) -- (X2);
  \draw[reg] (Y1) -- (Y2);
  
  % 交叉滞后
  \draw[reg] (X1) -- (Y2);
  \draw[reg] (Y1) -- (X2);
  
  % 同期相关
  \draw[cov] (X1) -- (Y1);
  \draw[cov] (X2) -- (Y2);
\end{tikzpicture}
```

### 5.10 随机截距交叉滞后模型（RI-CLPM）
**结构**：
- 随机截距因子（Trait）
- 状态层面的交叉滞后

**用途**：
- 区分个体间 vs 个体内效应

### 5.11 潜增长模型（LGCM）
**结构**：
- i（截距） → 所有时间点
- s（斜率） → 时间权重

**用途**：
- 发展趋势
- 变化轨迹分析

```latex
% LGCM示例（4个时间点）
\begin{tikzpicture}
  % 潜因子
  \node[latent] (i) at (0,2) {$i$};
  \node[latent] (s) at (3,2) {$s$};
  
  % 观测变量
  \node[manifest] (y1) at (0,0) {$y_1$};
  \node[manifest] (y2) at (1,0) {$y_2$};
  \node[manifest] (y3) at (2,0) {$y_3$};
  \node[manifest] (y4) at (3,0) {$y_4$};
  
  % 载荷
  \draw[reg] (i) -- node[left] {$1$} (y1);
  \draw[reg] (i) -- (y2);
  \draw[reg] (i) -- (y3);
  \draw[reg] (i) -- (y4);
  
  \draw[reg] (s) -- node[left] {$0$} (y1);
  \draw[reg] (s) -- node[left] {$1$} (y2);
  \draw[reg] (s) -- node[left] {$2$} (y3);
  \draw[reg] (s) -- node[left] {$3$} (y4);
  
  % 协方差
  \draw[cov] (i) -- (s);
\end{tikzpicture}
```

### 5.12 多水平 SEM（MSEM）
**结构**：
- 个体水平模型
- 群体水平模型
- 同一变量在不同层次

### 5.13 DSEM / 动态 SEM
**结构**：
- 时间序列 + SEM
- 自回归 + 交叉滞后 + 随机效应

**用途**：
- 密集追踪数据
- EMA / ESM

### 5.14 测量不变性模型（MI）
**结构**：
- 配置不变
- 载荷不变
- 截距不变
- 残差不变

**用途**：
- 多组/多时间比较

---

## 完整TikZ模板

```latex
\documentclass{article}
\usepackage{tikz}
\usetikzlibrary{shapes, arrows.meta, positioning}

\begin{document}

% 定义样式
\tikzstyle{latent} = [ellipse, draw, minimum width=2cm, minimum height=1cm]
\tikzstyle{manifest} = [rectangle, draw, minimum width=1.5cm, minimum height=0.8cm]
\tikzstyle{error} = [circle, draw, minimum size=0.6cm]
\tikzstyle{const} = [triangle, draw, minimum size=0.6cm]
\tikzstyle{reg} = [->, >=stealth]
\tikzstyle{cov} = [<->, >=stealth]
\tikzstyle{fixed} = [->, >=stealth, dashed]

% 在此处插入SEM图代码

\end{document}
```

---

## 使用建议

### 论文写作
- 图只画"结构"，参数约束写在caption或方法中
- 使用一致的符号系统
- 确保图例清晰

### 教学/科普
- 推荐：每个Prefab单独一张图
- 使用颜色区分不同类型的变量
- 添加注释说明箭头含义

### VS Code / Mplus 插件开发
- Prefab ≈ snippet / template
- 一键生成CFA/CLPM/LGCM框架
- 提供参数配置界面

---

## 注意事项

1. **符号一致性**：同一篇论文中保持符号系统一致
2. **路径标注**：重要路径应标注参数名称或数值
3. **图例清晰**：提供完整的图例说明
4. **尺寸适中**：确保图在论文中清晰可读
5. **版本兼容**：使用标准TikZ语法，确保LaTeX编译通过

---

## 总结

> SEM图 ≠ 装饰图  
> SEM图是一种**可视化统计语言**  
> 而Prefab Blocks = 这门语言的「语法模块」

使用本skill时，请确保：
1. 正确使用TikZ样式定义变量类型
2. 遵循SEM图的排版原则
3. 选择合适的预制块模板
4. 保持图形的学术规范性
