#include <cstdint>
#include <cuda_runtime.h>
#include <iomanip>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#include "../common/cu_commons.h"
#include "include.h"


extern "C" int float_cpu_save(Scope_Struct *scope_struct, void *tensor, int dims_prod, DT_str path){
    return 0;
}






extern "C" int bf16_cpu_save(Scope_Struct *scope_struct, void *tensor, int dims_prod, DT_str path) {
    uint16_t *tensor_cpu = *(uint16_t**)tensor;

    FILE *file = fopen(path.str, "wb");
    if (!file) {
        std::string path_str = path.str;
        LogErrorC(scope_struct->code_line, "Failed to save " + path_str);
        return -1;
    }
    

    float *float_buffer = (float *)malloc(dims_prod * sizeof(float));
    if (!float_buffer) {
        fclose(file);
        return -2;
    }

    for (int i = 0; i < dims_prod; ++i) {
        float_buffer[i] = bf16_to_float_inline(tensor_cpu[i]);
    }

    size_t written = fwrite(float_buffer, sizeof(float), dims_prod, file);

    free(float_buffer);
    fclose(file);

    // Return 0 on success, -3 if write failed
    return (written == (size_t)dims_prod) ? 0 : -3;
}



extern "C" int bf16_pp_save(Scope_Struct *scope_struct, void *tensor, int dims_prod, DT_str path){
    std::cout << "save bf16" << "";
    std::cout << "at " << path.str << "\n";
    std::cout << "dims " << dims_prod << "\n";

    uint16_t *tensor_cpu;
    cudaMalloc(&tensor_cpu, dims_prod*2);
    cudaMemcpy(tensor_cpu, *(uint16_t**)tensor, dims_prod*2, cudaMemcpyDeviceToHost);


    for (int i=0; i<10; ++i) {
        std::cout << "i: " << i << "\n";
        std::cout << "void: " << tensor_cpu[i] << "\n";
        float x_i = bf16_to_float_inline(tensor_cpu[i]);
        std::cout << x_i<< ", ";
    }
    return 0;
}
