# 使用说明

## Windows 版（`multi_wechat.bat`）

### 快速开始

1. 右键 `multi_wechat.bat`，选择"以管理员身份运行"（推荐，避免权限问题）
2. 在弹出的命令行窗口中输入要打开的微信数量
3. 等待脚本依次启动微信实例

### 自定义配置

打开 `multi_wechat.bat`，修改顶部变量：

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `WECHAT_PATH` | 微信可执行文件绝对路径 | `D:\Tencent\Weixin\Weixin.exe` |

启动间隔调整：修改 `ping -n 1 -w 500 127.0.0.1` 中的 `-w 500`（毫秒），值越大间隔越长。

---

## macOS 版（`multi_wechat_mac.sh`）

### 快速开始

```bash
cd /path/to/repo
chmod +x multi_wechat_mac.sh
./multi_wechat_mac.sh
```

按提示输入数量即可。

### 两种多开方式

脚本默认采用 **Method 2（拷贝 .app）**，更稳定可靠；可通过环境变量切换：

#### Method 1：`open -n` 直接新实例启动

```bash
USE_METHOD_1=1 ./multi_wechat_mac.sh
```

原理：macOS 的 `open -n` 会强制启动新实例（即使已有一个 WeChat 在运行）。在较新 macOS 上偶尔会弹出"已在运行"的提示框。

#### Method 2（默认）：复制 WeChat.app 到临时目录再启动

```bash
./multi_wechat_mac.sh
```

原理：每个实例从独立目录启动，绕过 macOS 的"同一 app 单实例"机制，最稳定。临时副本保存在 `/tmp/wechat_multi_*`。

### 自定义配置

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `WECHAT_APP`   | WeChat.app 路径 | `/Applications/WeChat.app` |
| `LAUNCH_DELAY` | 每个实例间延迟（秒） | `1` |
| `COPY_PREFIX`  | 临时副本目录前缀 | `/tmp/wechat_multi_` |
| `USE_METHOD_1` | `1` = 切换到 Method 1 | `0` |

### 清理临时副本

启动后会在 `/tmp` 留下若干 `wechat_multi_*` 目录（每个约 200MB），不需要时可手动清理：

```bash
rm -rf /tmp/wechat_multi_*
```

---

## 常见问题

### 启动后只有第一个微信能登录？

- **Windows**：确认微信版本支持多实例（一般 3.9+），或增大 `-w 500` 中的延迟值
- **macOS**：使用默认的 Method 2 即可解决；如果用 Method 1 仍有问题，切换到 Method 2

### macOS 提示 "App is damaged" 或 "cannot be opened"？

执行：
```bash
xattr -dr com.apple.quarantine /Applications/WeChat.app
```

### macOS 提示 "permission denied"？

```bash
chmod +x multi_wechat_mac.sh
```

### 微信安装路径找不到？

| 平台 | 查找方法 |
|------|----------|
| Windows | 右键桌面微信快捷方式 → 属性 → 复制"目标"中的 `.exe` 路径 |
| macOS   | 打开 Finder → 应用程序 → 找到 WeChat.app → 拖入终端查看路径 |

## 免责声明

本项目仅供学习与研究使用，多账号使用微信可能违反腾讯相关协议，请遵守当地法律法规及平台规则。
