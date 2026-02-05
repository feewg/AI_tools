# SEM图符号参考

## 变量类型符号

| 符号 | 类型 | LaTeX代码 | TikZ样式 | 含义 |
|------|------|-----------|----------|------|
| ○ | 潜变量 | `\xi`, `\eta`, `F` | `latent` | 不可直接观测的构念/因子 |
| □ | 观测变量 | `y`, `x`, `item` | `manifest` | 题项、指标、测量值 |
| ● | 误差项 | `\varepsilon`, `\zeta` | `error` | 未被模型解释的变异 |
| △ | 常数/截距 | `1`, `\alpha` | `const` | 均值结构、截距 |

## 路径类型符号

| 符号 | 类型 | LaTeX代码 | TikZ样式 | 含义 |
|------|------|-----------|----------|------|
| → | 单向箭头 | `a`, `b`, `\lambda` | `reg` | 回归路径、因子载荷 |
| ↔ | 双向箭头 | `\phi`, `\sigma` | `cov` | 协方差、相关 |
| ↺ | 自回路 | `\psi`, `\theta` | - | 方差 |
| →→ | 虚线箭头 | - | `fixed` | 固定参数、约束 |

## 常用希腊字母

| 符号 | LaTeX | 用途 |
|------|-------|------|
| ξ | `\xi` | 外生潜变量 |
| η | `\eta` | 内生潜变量 |
| λ | `\lambda` | 因子载荷 |
| γ | `\gamma` | 外生变量对内生变量的路径 |
| β | `\beta` | 内生变量之间的路径 |
| ε | `\varepsilon` | 指标测量误差 |
| ζ | `\zeta` | 内生潜变量扰动 |
| δ | `\delta` | 外生指标误差 |
| φ | `\phi` | 外生变量协方差 |
| ψ | `\psi` | 内生变量扰动方差 |
| θ | `\theta` | 误差项方差/协方差 |
| κ | `\kappa` | 外生变量均值 |
| α | `\alpha` | 截距 |

## 变量命名规范

### 潜变量命名
- 外生潜变量：`ξ1`, `ξ2`, `ξ3` 或 `X1`, `X2`, `X3`
- 内生潜变量：`η1`, `η2`, `η3` 或 `Y1`, `Y2`, `Y3`
- 因子：`F1`, `F2`, `F3` 或 `Factor1`, `Factor2`
- 截距因子：`i` 或 `intercept`
- 斜率因子：`s` 或 `slope`

### 观测变量命名
- 连续指标：`y1`, `y2`, `y3` 或 `x1`, `x2`, `x3`
- 问卷题项：`item1`, `item2`, `item3`
- 时间序列：`y1_t`, `y2_t` 或 `X_t`, `Y_t`
- 多指标：`y11`, `y12`, `y21`, `y22`（第一个数字为因子编号，第二个为指标编号）

### 误差项命名
- 指标误差：`ε1`, `ε2`, `ε3` 或 `e1`, `e2`, `e3`
- 扰动项：`ζ1`, `ζ2`, `ζ3` 或 `d1`, `d2`, `d3`
- 多指标误差：`ε11`, `ε12`, `ε21`, `ε22`

### 路径参数命名
- 因子载荷：`λ1`, `λ2`, `λ3`
- 回归系数：`γ11`, `β21`, `β32`
- 协方差：`φ12`, `φ21`
- 方差：`ψ1`, `θ11`

## 常用模型结构

### CFA模型
```
      F1
     /|\
    / | \
   y1 y2 y3
   |  |  |
   e1 e2 e3
```

### 中介模型
```
   X → M → Y
    \_____/
      c'
```

### 交叉滞后模型
```
   X1 → X2
    ↘   ↙
     ↕
    ↗   ↖
   Y1 → Y2
```

### 潜增长模型
```
   i → y1 y2 y3 y4
   |   |   |   |   |
   s → 0   1   2   3
```

## TikZ样式定义

```latex
% 基础样式
\tikzstyle{latent} = [ellipse, draw, minimum width=2cm, minimum height=1cm]
\tikzstyle{manifest} = [rectangle, draw, minimum width=1.5cm, minimum height=0.8cm]
\tikzstyle{error} = [circle, draw, minimum size=0.6cm]
\tikzstyle{const} = [triangle, draw, minimum size=0.6cm]

% 路径样式
\tikzstyle{reg} = [->, >=stealth]
\tikzstyle{cov} = [<->, >=stealth]
\tikzstyle{fixed} = [->, >=stealth, dashed]

% 高级样式
\tikzstyle{latent_highlight} = [ellipse, draw=red, thick, minimum width=2cm, minimum height=1cm]
\tikzstyle{manifest_highlight} = [rectangle, draw=blue, thick, minimum width=1.5cm, minimum height=0.8cm]
\tikzstyle{path_label} = [midway, above, font=\small]
```

## 常用LaTeX数学符号

### 关系符号
- `=` : 等于
- `\approx` : 约等于
- `\neq` : 不等于
- `\leq` / `\geq` : 小于等于 / 大于等于

### 运算符号
- `\times` : 乘号
- `\div` : 除号
- `\pm` : 正负号
- `\mp` : 负正号

### 集合符号
- `\in` : 属于
- `\subset` : 子集
- `\cup` : 并集
- `\cap` : 交集

### 逻辑符号
- `\forall` : 对于所有
- `\exists` : 存在
- `\rightarrow` : 推出
- `\leftrightarrow` : 当且仅当

### 其他符号
- `\infty` : 无穷大
- `\partial` : 偏导数
- `\nabla` : 梯度
- `\Delta` : 差分

## 颜色参考

| 颜色 | LaTeX代码 | 用途 |
|------|-----------|------|
| 黑色 | `black` | 默认 |
| 红色 | `red` | 强调、重要路径 |
| 蓝色 | `blue` | 外生变量 |
| 绿色 | `green` | 内生变量 |
| 紫色 | `purple` | 调节变量 |
| 橙色 | `orange` | 中介变量 |
| 灰色 | `gray` | 误差项、次要元素 |

使用示例：
```latex
\draw[reg, red, thick] (X) -- (Y);
\node[latent, fill=blue!20] (F) at (0,0) {$F$};
```
