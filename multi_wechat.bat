@echo off
setlocal enabledelayedexpansion

:: 设置微信程序路径
set "WECHAT_PATH=D:\Tencent\Weixin\Weixin.exe"

:: 检查微信程序是否存在
if not exist "%WECHAT_PATH%" (
    echo 错误：未找到微信程序，请检查路径是否正确！
    echo 当前设置的路径：%WECHAT_PATH%
    pause
    exit /b 1
)

:: 提示用户输入需要打开的微信数量
set /p "NUM=请输入需要打开的微信数量："

:: 验证输入是否为数字
echo %NUM%|findstr /r "^[0-9]*$" >nul
if errorlevel 1 (
    echo 错误：请输入有效的数字！
    pause
    exit /b 1
)

:: 检查输入是否为0或负数
if %NUM% leq 0 (
    echo 错误：请输入大于0的数字！
    pause
    exit /b 1
)

:: 循环启动微信
echo 正在启动 %NUM% 个微信...
for /l %%i in (1,1,%NUM%) do (
    echo 启动第 %%i 个微信...
    start "" "%WECHAT_PATH%"
    :: 延迟500毫秒，避免启动过于密集
    ping -n 1 -w 500 127.0.0.1 >nul
)

echo 所有微信已启动完成！
pause
