atn 07.apr.2023

=====================
Experiment set up: input_ad
=====================

**data**
bathymetry: 10m
nlfs + rfwf (the nlfs is not relevant in the 1D experiment, but not important for flooding test)
run for 1yr+1mo

**data.seaice**
initial ice: 5m
initial snow: 5m
all ice and snow albedos: 0.7
ice and snow density: set to 910 kg/m3

**data.exf**
air temperature above melting, repeat every 12mo
dsw and dlw: a seasonal cycle with elevated values
turned off check range

=====================================
code,build,run of upstream/master code
code_ad_master
build_ad_master
run_Ice5mSnow5m_SPoffFloodONSIsal0rhoSnow910albedo_master --> sst_heff_hsnow.png

code for PR 721:
code_ad
build_ad
run_Ice5mSnow5m_SPoffFloodONSIsal0rhoSnow910albedo --> sst_heff_hsnow.png

=====================================
script to run:
script_run.bash <-- edit to switch between the two runs above

=====================================
post-processing:
command_grep <--- extract monitored variables from STDOUT.0000
lookat_sst_heff_hsnow.m <-- load variables and produce figure sst_heff_hsnow.png

