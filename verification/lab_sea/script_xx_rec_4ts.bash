#!/bin/bash -x

dirroot=/workspace/atnguyen/sv-mnt-nansen/MITgcm_latest/MITgcm/verification/lab_sea
workdir1=$dirroot/run_4ts
mkdir $workdir1
mkdir $workdir1/diags
cd $workdir1
cp $dirroot/build_ad/mitgcmuv_ad $workdir1/
cp $dirroot/input_ad/data* $workdir1/
cp $workdir1/data_4ts $workdir1/data
cp $workdir1/data_ecco_4ts $workdir1/data.ecco
cp $dirroot/input_ad/eedata $workdir1/

cp $dirroot/input_ad/labsea_SST_fields_t5 $workdir1/
cp $dirroot/input_ad/sigma_sst.bin $workdir1/
cp $dirroot/../isomip/input_ad/ones_64b.bin $workdir1/

cp $dirroot/run_10ts/pickup*0000000005.* $workdir1/
cp $dirroot/input_ad/xx_atemp.0000000001.data $workdir1/
ln -s $dirroot/input/*labsea* $workdir1/
$workdir1/mitgcmuv_ad > $workdir1/stdout.0000
