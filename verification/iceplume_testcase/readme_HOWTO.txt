atn 25.oct.2022

The code_modX, X=1:7, provided here is to be used along with this FIRST commit to PR 652:

https://github.com/MITgcm/MITgcm/pull/652/commits/bae15e9985d4115320b31cedce7d18a4f28fa205
plus
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

