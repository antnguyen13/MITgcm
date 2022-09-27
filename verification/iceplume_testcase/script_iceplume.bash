#!/bin/bash -x

#--- 0.load modules ------
module purge
module load intel/18.0 mvapich2/2.2 phdf5 netcdf netcdf-fortran
#module load intel openmpi netcdf-fortran
ulimit -s hard
ulimit -u hard

#---- 1.set variables ------
#note for bash: can not have any space around =

whichcode=""
#========= THIS IS THE EXPERIMENT WE RUN ============
ext="c68k_tiny_nlfsrfwf_Qsg8_bathyclosed_r8"
#====================================================
#c68k atn local       c68k pull request, iceplume_testcase
#ext1="_demo"         --> mod0 (Tom's original code, brought to c68k)
#ext1="_mod1"         --> mod1
#ext1="_mod2"         --> mod2
#ext1="_mod4dI"       --> mod3
#ext1="_mod6h1"       --> mod4
#ext1="_mod7wrsg"     --> mod5
#ext1="_mod7Qsg"      --> mod6
#ext1="_mod7Qsg_exf1" --> mod7
#====================================================
#c65q and c67w:
#ext1="_mod1_budgc"
#ext1="_mod4"
#ext1="_mod4dI"
#ext1="_mod6"
#ext1="_mod6d"
#ext1="_mod6h1"
#ext1="_mod6h13"
#ext1="_mod7wrsg"
#ext1="_mod7Qsg_noabs_exf"
#ext1="_mod7Qsg_noabs_exf1_nobg"
#ext1="_mod7Qsg_noabs_exf1_clean"
#ext1="_mod7Qsg_noabs_exf1_budgc"
#ext1="_mod7Qsg_clean"

jobfile=script_iceplume.bash

basedir=/home/atnguyen/nansen/MITgcm_c68k/mysetups/Cowton2015/iceplume_testcase/
scratchdir=/scratch2/atnguyen/Cowton2015demo/iceplume_testcase/
binarydir=$basedir/input_binaries
mitgcmdir=/home/atnguyen/nansen/MITgcm_c68k/MITgcm

mod=0
modmax=7
while [ ! ${mod} -gt $modmax ]; do

  echo "mod = $mod"

  codedir=$basedir/code
#make the code dir:
  if [ ! -d $codedir ]; then
   mkdir -p $codedir
  fi

  cd $codedir
  rm *.F *.h packages.conf *.txt
  for (( i = 0; i<=${mod}; i++ ))
  do
    echo "i = $i"
    cp $basedir/code_mod${i}/* $codedir/
  done

#compiling
  builddir=$basedir/build
  if [ ! -d $builddir ]; then
   mkdir -p $builddir
  fi
  cd $builddir
  make CLEAN
  
  `../../../../MITgcm/tools/genmake2 -rd=../../../../MITgcm -mods=../code -of=/home/atnguyen/nansen/computing/optfiles/optfile_mvapich2_sverdrup -mpi`
  `make depend`
  `make -j 8`

#make namelist dir
  namelistdir=$basedir/namelist
  if [ ! -d $namelistdir ]; then
   mkdir -p $namelistdir
  fi
  cd $namelistdir
  rm *.F *.h packages.conf
  for (( i = 0; i<=${mod}; i++ ))
  do
    cp $basedir/namelist_mod${i}/* $namelistdir/
  done

#workdir
  workdir=$scratchdir/run_mod${mod}

  if [ ! -d $workdir ]; then
    mkdir -p $workdir;
    mkdir -p $workdir/diags;
  fi
  cd $workdir;
  rm -f $workdir/*
  rm -rf $workdir/code
  rm -rf $workdir/namelist
  rm -f $workdir/diags/*

#--- copy binary files:
  cp $binarydir/plumeMask_tiny.bin $workdir/
  cp $binarydir/delx_tiny.bin $workdir/
  cp $binarydir/dely_tiny.bin $workdir/
  cp $binarydir/bathymetry_tiny_closed.bin $workdir/
  cp $binarydir/tempini_tiny.bin $workdir/
  cp $binarydir/saltini_tiny.bin $workdir/
#for org, mod1-5:
  cp $binarydir/runoffVel_tiny_1mps.bin $workdir/
  cp $binarydir/runoffRad_tiny_8m3ps.bin $workdir/
#for mod6:
  cp $binarydir/runoffQsg_tiny_8m3ps.bin $workdir/
#for mod7:
  cp $binarydir/runoffQsg_tiny_8m3ps_9rec_constant.bin $workdir/

#--- 6. code, input (NAMELISTS), script ---------
  cp -rf ${codedir}/ ./
  cp -rf ${namelistdir}/ ./
  cp -f $namelistdir/* .
  cp -f ${basedir}/${jobfile} ./

#--- 7. executable --------
  cp -f $builddir/Makefile ./
  cp -f $builddir/mitgcmuv ./

#--- 11. run ----------------------------------
#cd to the run dir and execute ./mitgcmuv
  cd $workdir
  ./mitgcmuv

  let mod=mod+1
done
