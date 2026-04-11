#include "pool.h"

TensorArena tarena;

TensorSpan::TensorSpan(int elem_size) : elem_size(elem_size) {
    pages = std::max(1, (elem_size + page_size - 1) / page_size);
    int total_bytes = pages * page_size;
    N = total_bytes / elem_size;

    cudaMalloc(&addr, pages*page_size);
}


TensorArena::TensorArena() {}

void TensorArena::Reset() {
    for (int i=0; i<TSPANS; ++i) {
        TensorSpan *span = cur_span[i], *prev=nullptr;
        while (span) {
            span->free_idx=0;
            prev = span;
            span=span->next;
        }
        cur_span[i] = prev;
    }
}


extern "C" float tarena_reset(Scope_Struct *ctx) {
    tarena.Reset();
    return 0;
}

extern "C" float float_pp_protect(Scope_Struct *ctx, void *ptr, int size) {
    float *tensor_ptr;
    cudaMalloc(&tensor_ptr, size*4);
    cudaMemcpy(tensor_ptr, *(float**)ptr, size*4, cudaMemcpyDeviceToDevice);
    *(void**)ptr = tensor_ptr;
    return 0;
}

