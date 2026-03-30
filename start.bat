@echo off
chcp 65001 > nul
echo.
echo  ╔══════════════════════════════════╗
echo  ║         成语词典  启动中         ║
echo  ╚══════════════════════════════════╝
echo.

:: 检查数据文件
if not exist "data\chengyu.json" (
  echo  [!] 未找到数据文件，正在下载...
  call 下载数据.bat
  echo.
)

echo  [√] 数据文件就绪
echo  [→] 启动本地服务...
echo  [→] 浏览器地址：http://localhost:8080
echo.
echo  按 Ctrl+C 可关闭服务
echo.

:: 延迟1秒后打开浏览器
start /B cmd /C "timeout /t 1 > nul && start http://localhost:8080"

:: 优先用 Python
python -m http.server 8080 2>nul
if %errorlevel% equ 0 goto :end

:: Python3
python3 -m http.server 8080 2>nul
if %errorlevel% equ 0 goto :end

:: Node.js (npx serve)
npx --yes serve -l 8080 -s . 2>nul
if %errorlevel% equ 0 goto :end

echo  [!] 未检测到 Python 或 Node.js
echo      请安装 Python：https://python.org/downloads
pause

:end
