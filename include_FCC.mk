CC   = fcc
CXX  = FCC
LINKER = $(CXX)

ifeq ($(ENABLE_OPENMP),true)
OPENMP   = -Kopenmp
endif

CPPFLAGS   = -std=c++11 -Kfast -Kocl -Koptmsg=2 -Nlst=t ${OPENMP}
#-Ofast -ffreestanding -std=c99 $(OPENMP)
LFLAGS   = $(OPENMP)
DEFINES  = -D_GNU_SOURCE
INCLUDES =
LIBS     =

ENABLE_SCC ?= false
