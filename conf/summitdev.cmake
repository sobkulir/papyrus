set(CMAKE_C_COMPILER "mpicc")
set(CMAKE_CXX_COMPILER "mpic++")
set(CMAKE_C_FLAGS "")
set(CMAKE_CXX_FLAGS "-O2 -qlanglvl=extended0x")
set(MPIEXEC "mpirun")
set(MPIEXEC_NUMPROC_FLAG "-n")