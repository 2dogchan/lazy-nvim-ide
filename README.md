# ADE · Neovim for reviewing AI-written code

基于 [LazyVim](https://www.lazyvim.org) 的 Neovim 配置，定位是 **AI 时代的 review 编辑器**：
代码主要由 AI agent 写，这里负责快速读、看 diff、跑测试、和 Claude Code 对话。没有调试器。

- 语言：Rust、Go、Flutter/Dart、Protobuf（外加 Lua、JSON、YAML、TOML、Markdown）
- 外观：Zed 风格，OneDark warmer，winbar 面包屑，极简状态栏
- 原则：能用 LazyVim extra 就不引第三方插件

## 要求

- Neovim ≥ 0.12（`brew install neovim`）
- `git`、`rg`、`fd`、`lazygit`、C 编译器（treesitter）
- 语言工具链：`rustup component add rust-analyzer`、`go`、`flutter`。其余 LSP 和格式化工具由 mason 自动安装

```sh
git clone <this repo> ~/.config/nvim
nvim            # 首次启动会安装插件，之后 :checkhealth 看一眼
```

## 目录

```
lua/config/        lazy.lua（extras + 导入）· options · keymaps（所有自定义键位）· autocmds
lua/plugins/
  disabled.lua     关掉的插件都在这里，附替代品
  ui/              外观：colorscheme · statusline · dashboard · bufferline · scrollbar · indent-scroll · layout · folding
  editor/          导航：picker · explorer · flash · undotree · ssr · buffers
  review/          review 核心：git（gitsigns 行内 blame + diffview）
  coding/          通用：lsp（inlay hints / codelens / 诊断样式）· treesitter · neotest
  lang/            按语言：go · rust · flutter · lua · proto（buf 自带 LSP）
after/ftplugin/    各语言缩进
```

## 常用键位（自定义部分）

LazyVim 默认键位全部保留（`gd` `gr` `gI` `gy` `K`，`<leader>c` 代码，`<leader>g` git，`<leader>s` 搜索，`<leader>x` 诊断，`<leader>t` 测试，`<leader>u` 开关）。
注意 `gr` 带 `nowait`，所以 Neovim 自带的 `grr` / `grn` / `gra` 不会触发。

| 键 | 作用 |
|---|---|
| `<leader>ac` / `as` / `ab` | Claude Code：开关 / 发送选区 / 加入当前文件 |
| `<leader>aa` / `ad` | 接受 / 拒绝 Claude 的 diff |
| `<leader>gv` | 打开/关闭 Diffview（工作区全部改动） |
| `<leader>gH` | 当前文件历史（visual 模式：选中行的历史） |
| `<leader>uB` | 行内 blame 开关 |
| `<leader>ux` | 只显示 error 级诊断 |
| `<leader>uu` | 撤销树 |
| `<leader>ut` / `um` | 顶部函数上下文 / Markdown 渲染 |
| `<leader>cs` | 符号大纲 |
| `<leader>cc` | 执行光标处 codelens |
| `<leader>cE` | Rust：展开光标处的宏 |
| `<leader>e` / `E` | 文件树（cwd / 项目根） |
| `<leader>fa` | 搜文件，含隐藏和 gitignore |
| `<leader>xf` | 只列 FIXME |
| `<leader>;` | 关掉全部，回 dashboard |
| `Shift+Q` | 关当前 buffer |
| `Ctrl+点击` | 跳定义；已在定义上则列引用 |
| `zR` / `zM` / `zk` | 展开全部 / 折叠全部 / 预览折叠 |

个人习惯：`$` 和 `g_` 互换，`Ctrl+u/d` 固定移动 10 行，`Ctrl+e/y` 滚 3 行，`Alt+↑/↓` 移动行，`q` 默认不录宏（`<leader>uq` 开启）。
