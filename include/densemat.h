// ***************************************************
//
// A64FX SpMV code
//
// Author: Christie Alappat (christie.alappat@fau.de)
// Created: 2020
//
// ***************************************************


#ifndef _SpMV_DENSEMAT_H
#define _SpMV_DENSEMAT_H

#include <functional>

struct densemat
{
    int nrows;
    int ncols;
    double *val;

    void setVal(double value);
    void setRand();
//    void setFn(std::function<double(int)> fn);
    void setFn(std::function<double(void)> fn);

    densemat(int nrows, int ncols);
    ~densemat();

};

bool checkEqual(const densemat* lhs, const densemat* rhs, double tol=1e-4);

#endif
