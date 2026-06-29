#pragma once
#include "../../../src/nsk_cpp.h"


constexpr int TSPANS = 64;


struct TensorSpan {
    TensorSpan *next=nullptr, *prev=nullptr;
    int N, elem_size, page_size=8<<10, pages=1, free_idx=0;
    void *addr;
    TensorSpan(int);

    template<typename T>
    inline T *Allocate() {
        if (free_idx<N) {
            void *ret = (char*)addr + elem_size*free_idx;
            free_idx++;
            return (T*)ret;
        }
        return nullptr;
    }
};

struct TensorArena { 
    
    std::array<TensorSpan*, TSPANS> cur_span, first_span;

    TensorArena();
    void Reset();

    template<typename T>
    inline T *Allocate(int size) {
        size = size*sizeof(T);
        int exp = round_up_pow2_exp(size);
        int rsize = 1u << exp;
        // std::cout << "alloc size " << size << "\n";
        // std::cout << "alloc exp " << exp << "\n";
        // std::cout << "alloc rsize " << rsize << "\n";
        // std::cout << "\n";
        TensorSpan *span = cur_span[exp], *prev_span=nullptr;
        if (span) {
            T *ptr = span->Allocate<T>();
            if (ptr) return ptr;
            while (span->next) {
                span = span->next;
                T *ptr = span->Allocate<T>();
                if (ptr) {
                    cur_span[exp] = span;
                    return ptr;
                }
            }
            prev_span = span;
        }

        // Get new span
        span = new TensorSpan(rsize);
        if (prev_span) {
            prev_span->next = span;
            span->prev = prev_span;
        }
        cur_span[exp] = span;
        return span->Allocate<T>();
    }
};

extern TensorArena tarena;
