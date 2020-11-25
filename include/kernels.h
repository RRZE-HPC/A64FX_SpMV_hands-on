// ***************************************************
//
// A64FX SpMV code
//
// Author: Christie Alappat (christie.alappat@fau.de)
// Created: 2020
//
// ***************************************************


#ifndef _KERNELS_H
#define _KERNELS_H

#include "sparsemat.h"
#include "densemat.h"
#include <stdio.h>
#include "macros.h"

void spmv(densemat* b, sparsemat* mat, densemat* x);
void spmv_a64fx(densemat* b, sparsemat* mat, densemat* x);
void spmv_a64fx_sell32(densemat* b, sparsemat* mat, densemat* x);

#endif
