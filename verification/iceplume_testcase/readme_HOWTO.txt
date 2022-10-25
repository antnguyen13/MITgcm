atn 25.oct.2022

The code_modX, X=1:7, provided here is to be used along with this FIRST commit to PR 652:

https://github.com/MITgcm/MITgcm/pull/652/commits/bae15e9985d4115320b31cedce7d18a4f28fa205
https://github.com/MITgcm/MITgcm/pull/652/commits/26083ef989f8456fd5947f13e5ebd2b09831de51
https://github.com/MITgcm/MITgcm/pull/652/commits/c600612ed775b43c3272c8b0664cd10dec0f36f0

In this directory, I provide Tom's original test box -- files in input_binaries, 
along with with 7 modifications/fixes to Tom's code to fix bugs, improve physics, 
as well as reduce contradictory input params or global 3D fields being stored.

The steps to run the test case is as follows:

1. Check out the FIRST commit above, so that you have MITgcm/pkg/iceplume that is consistent
with Tom's original code.  
2. Edit the script file to:
  a) Modify the optfile to be based on your own machine's requirement,
  b) Choose the mod you want, ranging from 1-7,
  c) Change the loop maximum mod to be just the same as (b) if you just want to run that single experiment.

Then run the bash script.

The only potential error I expect is if your optfile is not consistent with some of the syntax in
the pkg/iceplume solvers.. If that can be solved, then the code should compile, and the rest of
the experiement should run.

In addition, I provide also my exampled optfile: optfile_mvapich2_sverdrup, specific to my machine, 
and note here that it works with loaded module
 1) intel/18.0   2) mvapich2/2.2   3) phdf5/1.10.1   4) netcdf/4.4.1.1   5) netcdf-fortran/4.4.4
and the LIBS in the optfile of
LIBS="-I${MPI_DIR}/lib -Wl,-rpath -Wl,${MPI_DIR}/lib -Wl,--enable-new-dtags -L${MPI_DIR}/lib -lmpi -L${NETCDF_FORTRAN_LIB} -L${NETCDF_LIB} -lnetcdf -lnetcdff

and also note that it did not work with the following openmpi module
  1) intel/18.0   2) openmpi/1.10.7   3) phdf5/1.10.1   4) netcdf/4.4.1.1   5) netcdf-fortran/4.4.4
and the LIBS in the optfile of 
> LIBS="-I${MPI_DIR}/lib -Wl,-rpath -Wl,${MPI_DIR}/lib -Wl,--enable-new-dtags -L${MPI_DIR}/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi -L${NETCDF_FORTRAN_LIB} -L${NETCDF_LIB} -lnetcdf -lnetcdff"

The mods correspond to subsequent commit to PR #652 as follow:
mod1: 
https://github.com/MITgcm/MITgcm/pull/652/commits/11647521fcf13eb7207c222153f410adb73a54ee 
https://github.com/MITgcm/MITgcm/pull/652/commits/83af3bc36283861173ffca876bcabaeaedc3a7fb

mod2: https://github.com/MITgcm/MITgcm/pull/652/commits/78513c52ac48aacf904acb9f34d0f36ef102ef8d
mod3: https://github.com/MITgcm/MITgcm/pull/652/commits/591b5e35d20f42ca6c7a56b83eebc09121036def
mod4: https://github.com/MITgcm/MITgcm/pull/652/commits/9f9ede31e5fda6b5ed336ac619adfa7b9175fa3a
mod5: https://github.com/MITgcm/MITgcm/pull/652/commits/9e8e82656d9a12a7748360f6858d06b1aefb8b17
mod6: https://github.com/MITgcm/MITgcm/pull/652/commits/29caa484b23a11d551cf11550f8c1624c5a71f2c
mod7: https://github.com/MITgcm/MITgcm/pull/652/commits/a242c5f936904f7a10f2fc777e8cc53bce541efd

