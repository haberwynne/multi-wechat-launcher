# Multi WeChat Launcher

A lightweight cross-platform toolkit for launching multiple WeChat (微信) client instances at the same time.

| Platform | Script | How it works |
|----------|--------|--------------|
| Windows  | `multi_wechat.bat`       | Loop `start "" Weixin.exe` with 500ms delay |
| macOS    | `multi_wechat_mac.sh`    | Copy `WeChat.app` to temp dir and `open -n` each copy |

## Features

- Start multiple WeChat instances in one click
- Input validation (positive integers only)
- Configurable launch interval
- Cross-platform: Windows BAT + macOS Shell
- No external dependencies

## Project Structure

```
.
├── README.md
├── multi_wechat.bat       # Windows version
├── multi_wechat_mac.sh    # macOS version
├── docs/
│   └── usage.md           # Detailed usage guide
└── .gitignore
```

## Quick Start

### Windows

1. Make sure WeChat (微信) is installed. Default path: `D:\Tencent\Weixin\Weixin.exe`
2. Edit `multi_wechat.bat` if your WeChat path is different
3. Double-click `multi_wechat.bat`
4. Enter the number of instances (e.g. `3`)

### macOS

1. Make sure WeChat is installed at `/Applications/WeChat.app`
2. Open Terminal, `cd` to the directory containing `multi_wechat_mac.sh`
3. Make it executable: `chmod +x multi_wechat_mac.sh`
4. Run it: `./multi_wechat_mac.sh`
5. Enter the number of instances

## Requirements

- Windows 7/10/11 or macOS 10.13+
- WeChat installed (PC / Mac client)

## Configuration

| Variable (Windows) | Default | Description |
|--------------------|---------|-------------|
| `WECHAT_PATH`      | `D:\Tencent\Weixin\Weixin.exe` | Path to WeChat executable |
| `ping -w` delay    | `500`   | Inter-launch delay in ms |

| Variable (macOS)   | Default | Description |
|--------------------|---------|-------------|
| `WECHAT_APP`       | `/Applications/WeChat.app` | Path to WeChat.app |
| `LAUNCH_DELAY`     | `1`     | Inter-launch delay in seconds |
| `COPY_PREFIX`      | `/tmp/wechat_multi_` | Temp dir for app copies |
| `USE_METHOD_1`     | `0`     | Set to `1` to use `open -n` directly (no copy) |

## Disclaimer

This project is for personal learning and research only. Multi-account usage of WeChat may violate Tencent's terms of service. Use at your own risk and please comply with local laws and platform rules.

## License

MIT (or use freely for personal purposes).
