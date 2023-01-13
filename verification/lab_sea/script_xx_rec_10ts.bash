#!/bin/bash -x

dirroot=/workspace/atnguyen/sv-mnt-nansen/MITgcm_latest/MITgcm/verification/lab_sea
workdir=$dirroot/run_10ts
mkdir $workdir
mkdir $workdir/diags
cd $workdir
cp $dirroot/build_ad/mitgcmuv_ad $workdir/
cp $dirroot/input_ad/data* $workdir/
cp $workdir/data_10ts $workdir/data
cp $workdir/data_ecco_10ts $workdir/data.ecco
cp $dirroot/input_ad/eedata $workdir/

cp $dirroot/input_ad/labsea_SST_fields_t10 $workdir/
cp $dirroot/input_ad/sigma_sst.bin $workdir/
cp $dirroot/../isomip/input_ad/ones_64b.bin $workdir/


cp $dirroot/input_ad/xx_atemp.0000000001.data $workdir/
ln -s $dirroot/input/*labsea* $workdir/
$workdir/mitgcmuv_ad > $workdir/stdout.0000
