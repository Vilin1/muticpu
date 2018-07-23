@echo off
set xv_path=D:\\AppTool\\vivado2015.2\\Vivado\\2015.2\\bin
call %xv_path%/xsim cpu_sim_behav -key {Behavioral:sim_1:Functional:cpu_sim} -tclbatch cpu_sim.tcl -view D:/vivado/myMCPU/cpu_sim_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
