
#include <iostream>

#include "minimal_tensor.h"
#include "pool/include.h"


CudaTensor::CudaTensor(Scope_Struct *scope_struct, int thread_id, int M, int N, std::string type) : M(M), N(N) {

    // std::cout << "\tCreating cuda tensor: M " << M << " N " << N << " type " << type << ".\n";


    if (type=="float")
    {
        aN = std::ceil(N / ((float)4))*4;
        // std::cout << "\tAllocating CudaTensor type float aN: " << aN << ".\n";

        tensor = (void*) get_from_pool(scope_struct, thread_id, M*aN, "CudaTensor "+type);

    }
    else if (type=="int8")
    {

    }
    else {
        std::cout << "CudaTensor type unknown: " << type << ".\n";
        std::exit(0);
    }
}