# SEM模型示例

## 1. 单因子CFA模型

### 模型描述
检验一个潜变量是否可以由多个观测指标测量。

### 应用场景
- 问卷信度检验
- 单维度构念验证
- 内部一致性检验

### Mplus代码示例
```
TITLE: Single-Factor CFA
DATA: FILE IS data.dat;
VARIABLE: NAMES ARE y1-y4;
MODEL:
  F1 BY y1 y2 y3 y4;
OUTPUT: STANDARDIZED;
```

### TikZ代码
```latex
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

---

## 2. 多因子CFA模型

### 模型描述
检验多个潜变量及其测量模型，包括因子间的相关关系。

### 应用场景
- 区分效度检验
- 多维度构念验证
- 因子结构探索

### Mplus代码示例
```
TITLE: Multi-Factor CFA
DATA: FILE IS data.dat;
VARIABLE: NAMES ARE y1-y6;
MODEL:
  F1 BY y1 y2 y3;
  F2 BY y4 y5 y6;
  F1 WITH F2;
OUTPUT: STANDARDIZED;
```

### TikZ代码
```latex
\begin{tikzpicture}
  \node[latent] (F1) at (0,2) {$F_1$};
  \node[latent] (F2) at (4,2) {$F_2$};
  \node[manifest] (y1) at (-1,0) {$y_1$};
  \node[manifest] (y2) at (1,0) {$y_2$};
  \node[manifest] (y3) at (3,0) {$y_3$};
  \node[manifest] (y4) at (5,0) {$y_4$};
  \draw[reg] (F1) -- (y1);
  \draw[reg] (F1) -- (y2);
  \draw[reg] (F2) -- (y3);
  \draw[reg] (F2) -- (y4);
  \draw[cov] (F1) -- (F2);
\end{tikzpicture}
```

---

## 3. 二阶因子模型

### 模型描述
一个高阶潜变量解释多个一阶潜变量的共变关系。

### 应用场景
- 人格结构研究（如大五人格）
- 能力结构分析
- 总体-子维度关系

### Mplus代码示例
```
TITLE: Second-Order Factor Model
DATA: FILE IS data.dat;
VARIABLE: NAMES ARE y1-y9;
MODEL:
  F1 BY y1 y2 y3;
  F2 BY y4 y5 y6;
  F3 BY y7 y8 y9;
  G BY F1 F2 F3;
OUTPUT: STANDARDIZED;
```

### TikZ代码
```latex
\begin{tikzpicture}[scale=0.7, transform shape]
  \node[latent] (G) at (4,4) {$G$};
  \node[latent] (F1) at (0,2) {$F_1$};
  \node[latent] (F2) at (4,2) {$F_2$};
  \node[latent] (F3) at (8,2) {$F_3$};
  \node[manifest] (y1) at (-1,0) {$y_1$};
  \node[manifest] (y2) at (1,0) {$y_2$};
  \node[manifest] (y3) at (3,0) {$y_3$};
  \node[manifest] (y4) at (5,0) {$y_4$};
  \node[manifest] (y5) at (7,0) {$y_5$};
  \draw[reg] (G) -- (F1);
  \draw[reg] (G) -- (F2);
  \draw[reg] (G) -- (F3);
  \draw[reg] (F1) -- (y1);
  \draw[reg] (F1) -- (y2);
  \draw[reg] (F2) -- (y3);
  \draw[reg] (F2) -- (y4);
  \draw[reg] (F3) -- (y5);
\end{tikzpicture}
```

---

## 4. 中介模型

### 模型描述
检验自变量通过中介变量影响因变量的机制。

### 应用场景
- 机制分析
- 间接效应检验
- 理论路径验证

### Mplus代码示例
```
TITLE: Mediation Model
DATA: FILE IS data.dat;
VARIABLE: NAMES ARE X M Y;
MODEL:
  Y ON M (b);
  M ON X (a);
  Y ON X (cprime);
MODEL CONSTRAINT:
  NEW(indirect);
  indirect = a*b;
OUTPUT: STANDARDIZED;
```

### TikZ代码
```latex
\begin{tikzpicture}
  \node[latent] (X) at (0,1) {$X$};
  \node[latent] (M) at (3,1) {$M$};
  \node[latent] (Y) at (6,1) {$Y$};
  \draw[reg] (X) -- node[above] {$a$} (M);
  \draw[reg] (M) -- node[above] {$b$} (Y);
  \draw[reg, bend left] (X) to node[above] {$c'$} (Y);
\end{tikzpicture}
```

---

## 5. 交叉滞后模型（CLPM）

### 模型描述
检验两个变量在多个时间点之间的交叉滞后效应。

### 应用场景
- 纵向因果推断
- 双向关系检验
- 发展轨迹分析

### Mplus代码示例
```
TITLE: Cross-Lagged Panel Model
DATA: FILE IS data.dat;
VARIABLE: NAMES ARE X1 Y1 X2 Y2;
MODEL:
  X2 ON X1 Y1;
  Y2 ON Y1 X1;
  X1 WITH Y1;
  X2 WITH Y2;
OUTPUT: STANDARDIZED;
```

### TikZ代码
```latex
\begin{tikzpicture}
  \node[latent] (X1) at (0,2) {$X_1$};
  \node[latent] (Y1) at (3,2) {$Y_1$};
  \node[latent] (X2) at (0,0) {$X_2$};
  \node[latent] (Y2) at (3,0) {$Y_2$};
  \draw[reg] (X1) -- (X2);
  \draw[reg] (Y1) -- (Y2);
  \draw[reg] (X1) -- (Y2);
  \draw[reg] (Y1) -- (X2);
  \draw[cov] (X1) -- (Y1);
  \draw[cov] (X2) -- (Y2);
\end{tikzpicture}
```

---

## 6. 潜增长模型（LGCM）

### 模型描述
检验变量随时间变化的趋势（截距和斜率）。

### 应用场景
- 发展趋势分析
- 变化轨迹建模
- 个体差异研究

### Mplus代码示例
```
TITLE: Latent Growth Curve Model
DATA: FILE IS data.dat;
VARIABLE: NAMES ARE y1-y4;
MODEL:
  i s | y1@0 y2@1 y3@2 y4@3;
OUTPUT: STANDARDIZED;
```

### TikZ代码
```latex
\begin{tikzpicture}
  \node[latent] (i) at (0,2) {$i$};
  \node[latent] (s) at (3,2) {$s$};
  \node[manifest] (y1) at (0,0) {$y_1$};
  \node[manifest] (y2) at (1,0) {$y_2$};
  \node[manifest] (y3) at (2,0) {$y_3$};
  \node[manifest] (y4) at (3,0) {$y_4$};
  \draw[reg] (i) -- node[left] {$1$} (y1);
  \draw[reg] (i) -- (y2);
  \draw[reg] (i) -- (y3);
  \draw[reg] (i) -- (y4);
  \draw[reg] (s) -- node[left] {$0$} (y1);
  \draw[reg] (s) -- node[left] {$1$} (y2);
  \draw[reg] (s) -- node[left] {$2$} (y3);
  \draw[reg] (s) -- node[left] {$3$} (y4);
  \draw[cov] (i) -- (s);
\end{tikzpicture}
```

---

## 7. 测量不变性模型

### 模型描述
检验测量模型在不同组别或时间点上的等价性。

### 应用场景
- 跨群体比较
- 纵向测量比较
- 多组分析

### Mplus代码示例
```
TITLE: Measurement Invariance
DATA: FILE IS data.dat;
VARIABLE: NAMES ARE y1-y4 group;
GROUPING = group (1=g1 2=g2);
MODEL:
  F1 BY y1 y2 y3 y4;
MODEL g1:
  F1 BY y1@1 y2 y3 y4;
MODEL g2:
  F1 BY y1@1 y2 y3 y4;
  [y1 y2 y3 y4];
  [F1];
OUTPUT: STANDARDIZED;
```

### 不变性层次
1. **配置不变性（Configural）**：因子结构相同
2. **度量不变性（Metric）**：因子载荷相等
3. **标量不变性（Scalar）**：截距相等
4. **严格不变性（Strict）**：误差方差相等

---

## 8. 多水平SEM（MSEM）

### 模型描述
同时建模个体层面和群体层面的结构关系。

### 应用场景
- 嵌套数据分析
- 跨层次效应检验
- 组织行为研究

### Mplus代码示例
```
TITLE: Multilevel SEM
DATA: FILE IS data.dat;
VARIABLE: NAMES ARE y1-y4 cluster;
CLUSTER = cluster;
WITHIN = y1-y4;
BETWEEN = y1-y4;
MODEL:
  % Within level
  % 模型代码
MODEL:
  % Between level
  % 模型代码
OUTPUT: STANDARDIZED;
```

---

## 模型选择指南

| 研究问题 | 推荐模型 |
|---------|---------|
| 检验构念结构 | CFA |
| 检验因果关系 | SEM |
| 检验中介机制 | 中介模型 |
| 检验双向关系 | CLPM |
| 检验变化趋势 | LGCM |
| 跨群体比较 | 测量不变性 |
| 嵌套数据分析 | MSEM |

## 模型拟合指标参考

| 指标 | 良好拟合 | 可接受 |
|------|---------|--------|
| χ²/df | < 2 | < 3 |
| CFI | > 0.95 | > 0.90 |
| TLI | > 0.95 | > 0.90 |
| RMSEA | < 0.05 | < 0.08 |
| SRMR | < 0.08 | < 0.10 |
