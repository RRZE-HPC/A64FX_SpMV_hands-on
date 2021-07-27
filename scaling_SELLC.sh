#!/usr/bin/env bash

#This script collects performance results over different number of threads for SELL-C-sigma SpMV

nthreads=48
printf "%5s, %12s, %12s\n" "#Thread" "Perf (GF/s)" "Speedup"
perf_single=1
for ((thread=1; thread<=${nthreads}; thread=${thread}+1)); do
	OMP_SCHEDULE=static OMP_NUM_THREADS=${thread} likwid-pin -c 0-$((thread-1)) ./spmv-SELLC-GCC &> tmp.tmp
	perf=$(cat tmp.tmp | grep "SPMV_A64FX :" | cut -d":" -f2 | cut -d"G" -f1)
	if [[ ${thread} == 1 ]]; then
		perf_single=${perf}
	fi
	speedup=$(echo "${perf}/${perf_single}" | bc -l)
	printf "%5d, %12.2f, %12.2f\n" ${thread} ${perf} ${speedup}
done

rm tmp.tmp
