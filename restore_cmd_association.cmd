@echo off
echo 正在修复.cmd 文件关联...
assoc .cmd=cmdfile
ftype cmdfile="%SystemRoot%\System32\cmd.exe" "%1" %*
echo 修复完成！请关闭所有窗口后重试。
pause
