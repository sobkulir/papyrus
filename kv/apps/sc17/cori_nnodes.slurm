#!/bin/bash -l

#SBATCH -C haswell
#SBATCH -p debug
#SBATCH -N 32
#SBATCH -t 00:30:00
#SBATCH -L SCRATCH,project
#SBATCH -J nnodes
#SBATCH --qos=premium
#DW jobdw capacity=1TB access_mode=striped type=scratch

export MPICH_MAX_THREAD_SAFETY=multiple
export MPICH_VERSION_DISPLAY=1

KEYLEN=16
VALLEN=131072
COUNT=100
RANKS=(1 2 4 8 16 32 64 128 256 512)

export PAPYRUSKV_REPOSITORY=$DW_JOB_STRIPED/pkv_nnodes
export PAPYRUSKV_DESTROY_REPOSITORY=0

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=1
export PAPYRUSKV_SSTABLE=1
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT put
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=1
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=4096
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=4096
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=1
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT
    sleep 5
done

export PAPYRUSKV_REPOSITORY=$SCRATCH/pkv_nnodes
export PAPYRUSKV_DESTROY_REPOSITORY=1

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=1
export PAPYRUSKV_SSTABLE=1
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT put
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=1
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT put
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=32
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT
    sleep 5
done

export PAPYRUSKV_REPOSITORY=$GPFS/pkv_nnodes
export PAPYRUSKV_DESTROY_REPOSITORY=1

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=1
export PAPYRUSKV_SSTABLE=1
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT put
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=1
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT put
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT
    sleep 5
done

export PAPYRUSKV_GROUP_SIZE=32
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${RANKS[@]}"; do
    srun -n $i -c 2 ./basic $KEYLEN $VALLEN $COUNT
    sleep 5
done

