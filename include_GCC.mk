CC   = gcc
CXX  = g++
LINKER = $(CXX)

ifeq ($(ENABLE_OPENMP),true)
OPENMP   = -fopenmp
endif

CPPFLAGS   = -std=c++11 -Ofast -mcpu=native -fopenmp-simd -funroll-loops -fno-builtin -msve-vector-bits=512 -march=armv8.2-a+sve ${OPENMP} -Wno-write-strings
#-Ofast -ffreestanding -std=c99 $(OPENMP)
LFLAGS   = $(OPENMP) #-Wl,-T/opt/FJSVxos/mmm/util/bss-2mb.lds -L/opt/FJSVxos/mmm/lib64
DEFINES  = -D_GNU_SOURCE
INCLUDES =
LIBS     = #-lmpg

ENABLE_SCC ?= false
