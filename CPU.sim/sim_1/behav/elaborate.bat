@echo off
set xv_path=D:\\AppTool\\vivado2015.2\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 5e7310a57af0444ca0d8e1cbade0e86e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot cpu_sim_behav xil_defaultlib.cpu_sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
