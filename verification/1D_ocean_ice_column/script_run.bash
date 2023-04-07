#!/bin/bash

  basedir=/workspace/atnguyen/sv-mnt-nansen/MITgcm_latest/MITgcm/verification/1D_ocean_ice_column

sset='_Ice5mSnow5m_SPoffFloodONSIsal0rhoSnow910albedo'
echo $sset

#PR
ext=''
#upstream/master
ext='_master'

  inputdir=$basedir/input_ad
  bindir=$basedir/dummy_bin
  codedir=$basedir/code_ad$ext
  builddir=$basedir/build_ad$ext

 workdir=$basedir/run${sset}${ext}

  mkdir -p $workdir;
  cd $workdir;
  cp -rp $codedir ./
  cp $inputdir/data* .
  cp $inputdir/eedata .
  cp $builddir/mitgcmuv_ad .
  cp $basedir/script_run.bash .

#  cp $bindir/bathy_10_1x1 .
#  cp $bindir/ones_1x1 .
#  cp $bindir/fives_1x1 .
#  cp $bindir/atemp_273p15_12rec_r4 .
#  cp $bindir/dsw_252_12rec_r4 .
#  cp $bindir/dlw_294_12rec_r4 .
#  cp $bindir/p1_13rec_r4 .
#  cp $bindir/zeros_13rec_p01_at_rec12_r4 .
#  cp $bindir/ones_1x1x23 .
   ln -s $bindir/* ./

  $workdir/mitgcmuv_ad > $workdir/STDOUT.0000
