## How to compile
* Configure using config.mk. Make sure the TAG is set to the proper compiler include file. For example TAG = GCCa64fx to include the file 'include_GCCa64fx.mk'. 
* For using LIKWID (optional): LIKWID library has to be installed (https://github.com/RRZE-HPC/likwid), `ENABLE_LIKWID` has to bet to true in config.mk. Proper paths has to be set in `include_LIKWID.mk`
* After configuration run `make` to compile


## How to run
* Get options using `./spmv-[TAG] -h`
* For running with HPCG matrix of size 128^3 on 1 CMG using SELL-32-1, currently only C=1 (CRS) and C=32 code is optimised:
```
OMP_NUM_THREADS=$thread OMP_PLACES=cores OMP_PROC_BIND=close ./spmv-[TAG] -S 128 -C 32 -Z 1
```
* For other matrices they can be read from MatrixMarket file using `-m` option.
