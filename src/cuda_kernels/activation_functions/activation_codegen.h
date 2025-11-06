#pragma once


#include <cublas_v2.h>
#include <cuda_fp16.h>
#include <mma.h>

#include "../../tensor/tensor_struct.h"


void relu_backward(Scope_Struct *, float *inp, int size, float *out,
                     float *dinp, float *dout,
                     void *, DT_tensor *node);

void gelu_backward(Scope_Struct *, float *inp, int size, float *out,
                     float *dinp, float *dout,
                     void *, DT_tensor *node);

void sigmoid_backward(Scope_Struct *, float *inp, int size, float *out,
                     float *dinp, float *dout,
                     void *, DT_tensor *node);

void tanh_backward(Scope_Struct *, float *inp, int size, float *out,
                     float *dinp, float *dout,
                     void *, DT_tensor *node);