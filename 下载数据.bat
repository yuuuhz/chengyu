@echo off
chcp 65001 > nul
echo.
echo  正在从 GitHub 下载成语数据库...
echo  文件大小约 10MB，请稍候...
echo.

if not exist "data" mkdir data

:: 尝试用 curl（Windows 10 自带）
curl -L --progress-bar "https://raw.githubusercontent.com/pwxcoo/chinese-xinhua/master/data/idiom.json" -o "data\idiom.json"
if %errorlevel% equ 0 (
  echo.
  echo  [√] 下载完成！
  goto :end
)

:: 尝试 PowerShell
echo  curl 失败，尝试 PowerShell...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/pwxcoo/chinese-xinhua/master/data/idiom.json' -OutFile 'data\idiom.json'"
if %errorlevel% equ 0 (
  echo  [√] 下载完成！
  goto :end
)

echo  [!] 自动下载失败，请手动下载：
echo.
echo  1. 打开浏览器访问：
echo     https://raw.githubusercontent.com/pwxcoo/chinese-xinhua/master/data/idiom.json
echo  2. 按 Ctrl+S 保存为 data\idiom.json
echo.
pause

:end
