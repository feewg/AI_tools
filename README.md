# AI Skills

这是一个AI技能集合项目，包含各种AI代理技能的定义和实现。

## 项目结构

```
AI_Tools/
├── skill_prompt/          # 技能提示文档
│   ├── tur.md           # Agent Skills教程
│   └── sem.md           # SEM图示通用规范
└── skills/              # 技能实现
    └── sem-diagram/     # SEM图示绘制技能
        ├── SKILL.md      # 技能说明文档
        ├── README.md     # 技能使用说明
        ├── scripts/      # 辅助脚本
        ├── templates/    # LaTeX模板
        └── resources/   # 参考资源
```

## 技能列表

### SEM图示绘制技能 (sem-diagram)

使用LaTeX/TikZ绘制结构方程模型(SEM)图示的完整工具集。

**功能特性：**
- 支持14种常见SEM模型（CFA、中介模型、CLPM、LGCM等）
- 提供Python脚本自动生成TikZ代码
- 包含完整的LaTeX模板
- 提供符号参考和模型示例

**快速开始：**
```bash
# 生成单因子CFA
python skills/sem-diagram/scripts/sem_generator.py --model cfa --indicators 4

# 生成中介模型
python skills/sem-diagram/scripts/sem_generator.py --model mediation --x X --m M --y Y
```

详细文档请查看 [`skills/sem-diagram/README.md`](skills/sem-diagram/README.md)

## 技能格式规范

本项目遵循 [Agent Skills](https://github.com/anthropics/skills) 规范：

```
skill-name/
├── SKILL.md          # 必需：技能说明文档
├── scripts/          # 可选：辅助脚本
├── templates/        # 可选：文档模板
└── resources/        # 可选：参考文件
```

### SKILL.md 格式

```markdown
---
name: skill-name
description: 技能描述
metadata:
  short-description: 简短描述
---

# 技能说明

详细的使用说明...
```

## 贡献

欢迎提交新的技能和改进建议！

## 许可证

MIT License
