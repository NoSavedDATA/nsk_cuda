#pragma once

__global__ void sgd_kernel(float* params_memory, const float* grads_memory,
                              float lr, int num_params);

__global__ void sgd_kernel_momentum(float* params_memory, const float* grads_memory, float* m_memory, long num_parameters,
                              float learning_rate, float momentum,
                              const float weight_decay, const float grad_clip); 
