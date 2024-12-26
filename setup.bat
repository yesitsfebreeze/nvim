@echo off

if not exist cfg.env (
	echo cfg.env file not found!
	exit /b 1
)

for /f "tokens=1,2 delims==" %%A in (cfg.env) do (
	set %%A=%%B
)