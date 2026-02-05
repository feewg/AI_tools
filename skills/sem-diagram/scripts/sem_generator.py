#!/usr/bin/env python3
"""
SEM图生成器 - 自动生成LaTeX/TikZ代码

使用方法:
    python sem_generator.py --model cfa --factors 3 --indicators 4
    python sem_generator.py --model mediation --x X --m M --y Y
    python sem_generator.py --model clpm --waves 3 --variables X Y
"""

import argparse
import sys


class SEMGenerator:
    """SEM图TikZ代码生成器"""
    
    def __init__(self):
        self.styles = self._get_styles()
    
    def _get_styles(self):
        """获取TikZ样式定义"""
        return r"""
\tikzstyle{latent} = [ellipse, draw, minimum width=2cm, minimum height=1cm]
\tikzstyle{manifest} = [rectangle, draw, minimum width=1.5cm, minimum height=0.8cm]
\tikzstyle{error} = [circle, draw, minimum size=0.6cm]
\tikzstyle{const} = [triangle, draw, minimum size=0.6cm]
\tikzstyle{reg} = [->, >=stealth]
\tikzstyle{cov} = [<->, >=stealth]
\tikzstyle{fixed} = [->, >=stealth, dashed]
"""
    
    def generate_cfa(self, factors=3, indicators_per_factor=4):
        """生成CFA模型"""
        code = []
        code.append("% 单因子CFA模型")
        code.append("\\begin{tikzpicture}")
        
        # 潜变量
        code.append(f"  % 潜变量")
        code.append(f"  \\node[latent] (F1) at (0,2) {{$F_1$}};")
        
        # 观测变量
        code.append(f"  % 观测变量")
        start_x = -(indicators_per_factor - 1) / 2
        for i in range(indicators_per_factor):
            x = start_x + i * 2
            code.append(f"  \\node[manifest] (y{i+1}) at ({x},0) {{$y_{i+1}$}};")
        
        # 误差项
        code.append(f"  % 误差项")
        for i in range(indicators_per_factor):
            x = start_x + i * 2
            code.append(f"  \\node[error] (e{i+1}) at ({x},-1) {{$\\varepsilon_{i+1}$}};")
        
        # 路径
        code.append(f"  % 因子载荷")
        for i in range(indicators_per_factor):
            code.append(f"  \\draw[reg] (F1) -- (y{i+1});")
        
        code.append(f"  % 测量误差")
        for i in range(indicators_per_factor):
            code.append(f"  \\draw[reg] (e{i+1}) -- (y{i+1});")
        
        code.append("\\end{tikzpicture}")
        return "\n".join(code)
    
    def generate_multifactor_cfa(self, factors=3, indicators_per_factor=4):
        """生成多因子CFA模型"""
        code = []
        code.append("% 多因子CFA模型")
        code.append("\\begin{tikzpicture}")
        
        # 潜变量
        code.append(f"  % 潜变量")
        for f in range(factors):
            x = f * 4
            code.append(f"  \\node[latent] (F{f+1}) at ({x},2) {{$F_{f+1}$}};")
        
        # 观测变量和误差项
        code.append(f"  % 观测变量和误差项")
        for f in range(factors):
            x_base = f * 4
            start_x = x_base - (indicators_per_factor - 1) * 0.5
            for i in range(indicators_per_factor):
                x = start_x + i * 1.2
                code.append(f"  \\node[manifest] (y{f+1}{i+1}) at ({x},0) {{$y_{f+1}{i+1}$}};")
                code.append(f"  \\node[error] (e{f+1}{i+1}) at ({x},-1) {{$\\varepsilon_{f+1}{i+1}$}};")
        
        # 路径
        code.append(f"  % 因子载荷")
        for f in range(factors):
            for i in range(indicators_per_factor):
                code.append(f"  \\draw[reg] (F{f+1}) -- (y{f+1}{i+1});")
        
        code.append(f"  % 测量误差")
        for f in range(factors):
            for i in range(indicators_per_factor):
                code.append(f"  \\draw[reg] (e{f+1}{i+1}) -- (y{f+1}{i+1});")
        
        # 潜变量协方差
        code.append(f"  % 潜变量协方差")
        for f in range(factors - 1):
            code.append(f"  \\draw[cov] (F{f+1}) -- (F{f+2});")
        
        code.append("\\end{tikzpicture}")
        return "\n".join(code)
    
    def generate_mediation(self, x="X", m="M", y="Y", direct=True):
        """生成中介模型"""
        code = []
        code.append("% 中介模型")
        code.append("\\begin{tikzpicture}")
        
        code.append(f"  % 变量")
        code.append(f"  \\node[latent] (X) at (0,1) {{$x$}};")
        code.append(f"  \\node[latent] (M) at (3,1) {{$m$}};")
        code.append(f"  \\node[latent] (Y) at (6,1) {{$y$}};")
        
        code.append(f"  % 路径")
        code.append(f"  \\draw[reg] (X) -- node[above] {{$a$}} (M);")
        code.append(f"  \\draw[reg] (M) -- node[above] {{$b$}} (Y);")
        
        if direct:
            code.append(f"  \\draw[reg, bend left] (X) to node[above] {{$c'$}} (Y);")
        
        code.append("\\end{tikzpicture}")
        return "\n".join(code)
    
    def generate_clpm(self, waves=3, variables=["X", "Y"]):
        """生成交叉滞后模型"""
        code = []
        code.append(f"% 交叉滞后模型（{waves}波次）")
        code.append("\\begin{tikzpicture}")
        
        # 创建变量节点
        for t in range(waves):
            y_pos = (waves - 1 - t) * 2
            for i, var in enumerate(variables):
                x_pos = i * 3
                code.append(f"  \\node[latent] ({var}{t+1}) at ({x_pos},{y_pos}) {{$var_{t+1}$}};")
        
        # 自回归路径
        code.append(f"  % 自回归路径")
        for var in variables:
            for t in range(waves - 1):
                code.append(f"  \\draw[reg] ({var}{t+1}) -- ({var}{t+2});")
        
        # 交叉滞后路径
        code.append(f"  % 交叉滞后路径")
        for t in range(waves - 1):
            code.append(f"  \\draw[reg] (X{t+1}) -- (Y{t+2});")
            code.append(f"  \\draw[reg] (Y{t+1}) -- (X{t+2});")
        
        # 同期相关
        code.append(f"  % 同期相关")
        for t in range(waves):
            code.append(f"  \\draw[cov] (X{t+1}) -- (Y{t+1});")
        
        code.append("\\end{tikzpicture}")
        return "\n".join(code)
    
    def generate_lgcm(self, time_points=4):
        """生成潜增长模型"""
        code = []
        code.append(f"% 潜增长模型（{time_points}个时间点）")
        code.append("\\begin{tikzpicture}")
        
        # 潜因子
        code.append(f"  % 潜因子")
        code.append(f"  \\node[latent] (i) at (0,2) {{$i$}};")
        code.append(f"  \\node[latent] (s) at (3,2) {{$s$}};")
        
        # 观测变量
        code.append(f"  % 观测变量")
        for t in range(time_points):
            x = t
            code.append(f"  \\node[manifest] (y{t+1}) at ({x},0) {{$y_{t+1}$}};")
        
        # 截距载荷
        code.append(f"  % 截距载荷")
        for t in range(time_points):
            label = "$1$" if t == 0 else ""
            code.append(f"  \\draw[reg] (i) -- node[left] {{{label}}} (y{t+1});")
        
        # 斜率载荷
        code.append(f"  % 斜率载荷")
        for t in range(time_points):
            label = f"${t}$"
            code.append(f"  \\draw[reg] (s) -- node[left] {{{label}}} (y{t+1});")
        
        # 协方差
        code.append(f"  % 协方差")
        code.append(f"  \\draw[cov] (i) -- (s);")
        
        code.append("\\end{tikzpicture}")
        return "\n".join(code)
    
    def generate_full_document(self, model_code, title="SEM图"):
        """生成完整的LaTeX文档"""
        doc = []
        doc.append(r"\documentclass{article}")
        doc.append(r"\usepackage{tikz}")
        doc.append(r"\usetikzlibrary{shapes, arrows.meta, positioning}")
        doc.append(r"\usepackage{amsmath}")
        doc.append("")
        doc.append(r"\begin{document}")
        doc.append("")
        doc.append(f"\\section*{{{title}}}")
        doc.append("")
        doc.append(self.styles)
        doc.append("")
        doc.append(model_code)
        doc.append("")
        doc.append(r"\end{document}")
        return "\n".join(doc)


def main():
    parser = argparse.ArgumentParser(description="SEM图生成器")
    parser.add_argument("--model", choices=["cfa", "multifactor", "mediation", "clpm", "lgcm"],
                        required=True, help="模型类型")
    parser.add_argument("--factors", type=int, default=3, help="因子数量（CFA）")
    parser.add_argument("--indicators", type=int, default=4, help="每个因子的指标数（CFA）")
    parser.add_argument("--x", default="X", help="自变量名称（中介模型）")
    parser.add_argument("--m", default="M", help="中介变量名称（中介模型）")
    parser.add_argument("--y", default="Y", help="因变量名称（中介模型）")
    parser.add_argument("--no-direct", action="store_true", help="不包含直接路径（中介模型）")
    parser.add_argument("--waves", type=int, default=3, help="波次数量（CLPM）")
    parser.add_argument("--variables", nargs="+", default=["X", "Y"], help="变量列表（CLPM）")
    parser.add_argument("--time-points", type=int, default=4, help="时间点数量（LGCM）")
    parser.add_argument("--full-doc", action="store_true", help="生成完整LaTeX文档")
    parser.add_argument("--output", "-o", help="输出文件路径")
    
    args = parser.parse_args()
    
    generator = SEMGenerator()
    
    # 生成模型代码
    if args.model == "cfa":
        model_code = generator.generate_cfa(args.indicators)
    elif args.model == "multifactor":
        model_code = generator.generate_multifactor_cfa(args.factors, args.indicators)
    elif args.model == "mediation":
        model_code = generator.generate_mediation(args.x, args.m, args.y, not args.no_direct)
    elif args.model == "clpm":
        model_code = generator.generate_clpm(args.waves, args.variables)
    elif args.model == "lgcm":
        model_code = generator.generate_lgcm(args.time_points)
    else:
        print(f"未知模型类型: {args.model}", file=sys.stderr)
        return 1
    
    # 输出
    if args.full_doc:
        output = generator.generate_full_document(model_code, f"{args.model.upper()}模型")
    else:
        output = generator.styles + "\n" + model_code
    
    if args.output:
        with open(args.output, "w", encoding="utf-8") as f:
            f.write(output)
        print(f"已生成文件: {args.output}")
    else:
        print(output)
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
