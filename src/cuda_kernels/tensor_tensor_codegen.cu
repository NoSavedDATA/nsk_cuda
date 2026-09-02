#include <vector>
#include <iostream>
#include <cuda_runtime.h>


#include "../../../src/nsk_cpp.h"


#include "../pool/include.h"
#include "../common/cu_commons.h"
#include "../cuda_threads/include.h"
#include "../mma/general.h"
#include "../nsk_cuda/pool/include.h"
#include "../tensor/include.h"
#include "activation_functions/activation_kernels.h"
#include "include.h"

extern "C" void *add_tensors(Scope_Struct *scope_struct, void *x, void *y, int dims) {
    int tid = scope_struct->thread_id;
    cudaStream_t stream = ThreadsStream[tid];
    void **z = allocate<void*>(scope_struct, 1, "float_pp");
    float *tensor_ptr = tarena.Allocate<float>(dims);
    *z = tensor_ptr;

    add_forward<<<(dims+255)/256, 256, 0, stream>>>(*((float**)z), *((float**)x), *((float**)y), dims);
    return (void*)z;
}

extern "C" float acc_tensors(Scope_Struct *scope_struct, void *x, void *y, int dims) {
    int tid = scope_struct->thread_id;
    cudaStream_t stream = ThreadsStream[tid];

    add_inplace<<<(dims+255)/256, 256, 0, stream>>>(*((float**)x), *((float**)y), dims);
    return 0;
}

extern "C" void *mma_tensors(Scope_Struct *scope_struct, void *x, void *y, int m, int n, int p) {
    int tid = scope_struct->thread_id;
    cudaStream_t stream = ThreadsStream[tid];

    void **z = allocate<void*>(scope_struct, 1, "float_pp");
    float *tensor_ptr = tarena.Allocate<float>(m*p);
    *z = tensor_ptr;

    matmul_forward(*(float**)z, *(float**)x, *(float**)y,
                  m, n, p, tid);

    return (void*)z;
}


extern "C" void *relu_k(Scope_Struct *scope_struct, void *x, int dims_prod) {
  int tid = scope_struct->thread_id;
  cudaStream_t stream = ThreadsStream[tid];

  int grid_size, block_size;
  CalculateGridAndBlockSizes(dims_prod, grid_size, block_size);
  float *out = tarena.Allocate<float>(dims_prod);
  
  relu_forward<<<grid_size, block_size, 0, stream>>>(*(float**)x, out, dims_prod);

  void **z = allocate<void*>(scope_struct, 1, "float_pp");
  *z = out;
  return (void*)z;
}
extern "C" int relu_backward_k(Scope_Struct *scope_struct, void *dout, void *x, void *y, int dims_prod) {
  int tid = scope_struct->thread_id;
  cudaStream_t stream = ThreadsStream[tid];

  int grid_size, block_size;
  CalculateGridAndBlockSizes(dims_prod, grid_size, block_size);
  
  relu_backward1<<<grid_size, block_size, 0, stream>>>(*(float**)y, *(float**)dout, *(float**)x, dims_prod);

  return 0;
}

extern "C" void *softmax_k(Scope_Struct *scope_struct, void *x, int M, int N) {
  int tid = scope_struct->thread_id;
  cudaStream_t stream = ThreadsStream[tid];
  int dims_prod = M*N;

  std::vector<int> grid_block_mem_sizes;
  grid_block_mem_sizes = CalculateGridAndBlockSizes(dims_prod);
  int grid_size  = M;
  int block_size = grid_block_mem_sizes[1];
  int shared_mem_size = 2 * block_size / 32 * sizeof(float);
  float *probs = tarena.Allocate<float>(dims_prod);
  
  softmax_forward_kernel4<<<grid_size, block_size, shared_mem_size, stream>>>(*(float**)x, probs, M, N);

  void **z = allocate<void*>(scope_struct, 1, "float_pp");
  *z = probs;
  return (void*)z;

    // int tid = scope_struct->thread_id;
    // cudaStream_t stream = ThreadsStream[tid];

    // void **z = allocate<void*>(scope_struct, 1, "float_pp");
    // float *tensor_ptr = tarena.Allocate<float>(m*p);
    // *z = tensor_ptr;
    // // cudaMalloc(z, m*p*4);

    // // std::cout << "x " << x << ", y " << y << ", z " << z << "\n";
    // // std::cout << "m " << m << ", n " << n << ", p " << p << "\n";
    // matmul_forward(*(float**)z, *(float**)x, *(float**)y,
    //               m, n, p, tid);

    // return (void*)z;
}




extern "C" void neve_gpu_launch(char *fn, char *ptx,
        int gx, int gy, int gz, int bx, int by, int bz,
        int smem,
        void **args) {

    cuInit(0);

    CUcontext ctx;
    cuCtxGetCurrent(&ctx);

    if (!ctx) {
        fprintf(stderr, "No active CUDA context\n");
        abort();
    }
    // std::cout << "" << ptx << "";

    CUfunction kernel;
    CUmodule gpuModule;

    cuModuleLoadDataEx(
        &gpuModule,
        ptx,
        0,
        nullptr,
        nullptr
    );

    CUresult res = cuModuleGetFunction(
        &kernel,
        gpuModule,
        fn
    );


    if (res != CUDA_SUCCESS) {
        const char *name;
        const char *str;

        cuGetErrorName(res, &name);
        cuGetErrorString(res, &str);

        std::cout << "LAUNCH ERROR" << "\n";
        printf("%s: %s\n", name, str);
        std::cout << ptx << "\n";
        abort();
    }


    // int gx=1, gy=1, gz=1;
    // int bx=32, by=1, bz=1;


    std::cout << "grid (" << gx << ", " << gy << ", " << gz << ")" << "\n";
    std::cout << "block (" << bx << ", " << by << ", " << bz << ")" << "\n";
    std::cout << "smem " << smem << "\n";

    res = cuLaunchKernel(
        kernel,
        gx, gy, gz,
        bx, by, bz,
        smem,
        0,
        args,
        nullptr
    );
    // cudaDeviceSynchronize();

    if (res != CUDA_SUCCESS) {
        std::cout << "--KERNEL ERROR " << res << "\n";
        const char *name;
        const char *str;

        cuGetErrorName(res, &name);
        cuGetErrorString(res, &str);

        printf("%s: %s\n", name, str);
        abort();
        std::exit(0);
    }

}


extern "C" int smem_size_fn(Scope_Struct *ctx) {
  return deviceProp.sharedMemPerBlock;
  // return deviceProp.sharedMemPerBlockOptin;
}



//extern "C" DT_tensor *tensor_tensor_mma(Scope_Struct *scope_struct, DT_tensor *tensor_x, DT_tensor *tensor_w) {

//  int thread_id = scope_struct->thread_id;

//  std::vector<int> Ldims, Rdims;
//  Ldims = tensor_x->dims;
//  Rdims = tensor_w->dims;
//  float *device_x = tensor_x->tensor_ptr;
//  float *device_w = tensor_w->tensor_ptr;


//  std::vector<int> linear_layer_dims = format_LinearLayer_Dims(Ldims);
//  int input_dims_prod = DimsProd(linear_layer_dims);
  
//  int resultingDimsProd = resultingDimsProdOnMult(linear_layer_dims, Rdims);


//  float* device_y = get_from_pool(scope_struct, thread_id, resultingDimsProd, "cuda mult");
    

//  if (Ldims.size()<2)
//    LogErrorC(scope_struct->code_line, "Tensors matrix multiplication requires tensors of at least 2 dimensions.");



//  tensor_x->Sync();
//  tensor_w->Sync();

//  matmul_forward(device_y, device_x, device_w,
//                  linear_layer_dims[0], linear_layer_dims[1],
//                  Rdims[0], thread_id);

  
  
//  std::vector<int> new_dims = NewDimsOnMult(Ldims, Rdims);

//  DT_tensor *new_tensor = createTensor(scope_struct, device_y, new_dims, resultingDimsProd, false, "");
//  new_tensor->AttrNodes(tensor_x, tensor_w, mult_op);
  
//  return new_tensor;
//}


//extern "C" DT_tensor *tensor_tensor_add(Scope_Struct *scope_struct, DT_tensor *tensor_x, DT_tensor *tensor_w) {

//  //std::cout << "Cuda add of\n      L " << tensor_x.name << "  &  R " << tensor_w.name << "\n";
    
//  int thread_id = scope_struct->thread_id;

//  std::vector<int> Ldims, Rdims;
//  Ldims = tensor_x->dims;
//  Rdims = tensor_w->dims;
//  float *device_x = tensor_x->tensor_ptr;
//  float *device_w = tensor_w->tensor_ptr;




//  std::vector<int> linear_layer_dims = format_LinearLayer_Dims(Ldims);
//  float dims_prod = tensor_x->dims_prod;


//  float* device_y = get_from_pool(scope_struct, thread_id, dims_prod, "add");


//  tensor_x->Sync();
//  tensor_w->Sync();
//  cudaStream_t stream = ThreadsStream[thread_id];



//  if (Ldims==Rdims)
//  {

//    int grid_size, block_size;
//    CalculateGridAndBlockSizes(dims_prod, grid_size, block_size);
    
//    add_forward<<<grid_size, block_size, 0, stream>>>(device_y, device_x, device_w, dims_prod);
    

//    DT_tensor *new_tensor = createTensor(scope_struct, device_y, Ldims, dims_prod, false, "");
//    new_tensor->AttrNodes(tensor_x, tensor_w, add_op);
//    return new_tensor;
//  }

  

  
//  if(RemoveLastDim(Ldims)==Rdims||(RemoveLastDim(Ldims)==RemoveLastDim(Rdims)&&Rdims[Rdims.size()-1]==1))
//  {
//    int grid_size, block_size;
//    CalculateGridAndBlockSizes(dims_prod, grid_size, block_size);
    
//    broadcast_lastdim_add<<<grid_size, block_size, 0, stream>>>(device_y, device_x, device_w, dims_prod, tensor_x->dims[tensor_x->dims.size()-1]);
    

//    DT_tensor *new_tensor = createTensor(scope_struct, device_y, Ldims, dims_prod, false, "");
//    new_tensor->AttrNodes(tensor_x, tensor_w, broadcast_lastdim_add_op);
//    return new_tensor;
//  }


//  if (Ldims!=Rdims)
//  {
//    LogErrorC(scope_struct->code_line, "Tried to add tensors of different dimenstions.");
//    std::cout << "   Left tensor dims " << "\n   ";
//    PrintDims(Ldims);
//    std::cout << "\n   Right tensor dims " << "\n   ";
//    PrintDims(Rdims);
//    std::cout << "\n\n";
//    return nullptr;
//  }
//}


//extern "C" DT_tensor *tensor_tensor_sub(Scope_Struct *scope_struct, DT_tensor *tensor_x, DT_tensor *tensor_w) {

//  int thread_id = scope_struct->thread_id;

//  //std::cout << "Cuda add of\n      L " << tensor_x.name << "  &  R " << tensor_w.name << "\n";
    
//  std::vector<int> Ldims, Rdims;
//  Ldims = tensor_x->dims;
//  Rdims = tensor_w->dims;
//  float *device_x = tensor_x->tensor_ptr;
//  float *device_w = tensor_w->tensor_ptr;


//  std::vector<int> linear_layer_dims = format_LinearLayer_Dims(Ldims);
//  float dims_prod = tensor_x->dims_prod;




//  float* device_y = get_from_pool(scope_struct, thread_id, dims_prod,"sub");



//  int grid_size = dims_prod;
//  int block_size = 512;
  
//  tensor_x->Sync();
//  tensor_w->Sync();
//  cudaStream_t stream = ThreadsStream[thread_id];
//  sub_forward<<<grid_size, block_size, 0, stream>>>(device_y, device_x, device_w, dims_prod);
  
  
//  DT_tensor *new_tensor = createTensor(scope_struct, device_y, Ldims, dims_prod, false, "");  
//  new_tensor->AttrNodes(tensor_x, tensor_w, sub_op);
//  return new_tensor;
//}


//extern "C" DT_tensor *tensor_tensor_equal(Scope_Struct *scope_struct, DT_tensor *tensor_x, DT_tensor *tensor_w) {

//  int thread_id = scope_struct->thread_id;
                            
    
//  std::vector<int> Ldims, Rdims;
//  Ldims = tensor_x->dims;
//  Rdims = tensor_w->dims;
//  float *device_x = tensor_x->tensor_ptr;
//  float *device_w = tensor_w->tensor_ptr;


//  float dims_prod = tensor_x->dims_prod;


//  float* device_y = get_from_pool(scope_struct, thread_id, dims_prod, "equal op");


//  int grid_size, block_size; 
//  CalculateGridAndBlockSizes(dims_prod, grid_size, block_size);
  
//  tensor_x->Sync();
//  tensor_w->Sync();
//  cudaStream_t stream = ThreadsStream[thread_id];
//  equal_forward<<<grid_size, block_size, 0, stream>>>(device_y, device_x, device_w, dims_prod);
  
  
//  DT_tensor *new_tensor = createTensor(scope_struct, device_y, Ldims, dims_prod, false, "");  
//  new_tensor->AttrNodes(tensor_x, tensor_w, equal_op);
//  return new_tensor;
//}


//extern "C" DT_tensor *tensor_tensor_mult(Scope_Struct *scope_struct, DT_tensor *tensor_x, DT_tensor *tensor_w) {

//  int thread_id = scope_struct->thread_id;

//  //std::cout << "      L " << tensor_x.name << "  &  R " << tensor_w.name << "\n";
    
//  std::vector<int> Ldims, Rdims;
//  Ldims = tensor_x->dims;
//  Rdims = tensor_w->dims;
//  float *device_x = tensor_x->tensor_ptr;
//  float *device_w = tensor_w->tensor_ptr;

//  float dims_prod = tensor_x->dims_prod;


//  cudaStream_t stream = ThreadsStream[thread_id];
//  if (Ldims!=Rdims) //Then broadcast
//  { //TODO: change kernel instead
//    bool first_iter = true;
//    while (Ldims.size()>Rdims.size())
//    {
//      float tgt_dim_size = Ldims[Rdims.size()];
//      float aux_size = DimsProd(Rdims);
//      float *aux_tensor, *aux_free;
//      cudaMalloc(&aux_tensor, round_to_nearest_pow2(aux_size*tgt_dim_size)*sizeof(float));
//      cudaMemset(aux_tensor, 0, aux_size*tgt_dim_size*sizeof(float));
      
//      int grid_size = dims_prod;
//      int block_size = 32;
//      size_t shared_mem_size = 2 * block_size / 32 * sizeof(float);
//      repeat_interleave_kernel_last_dim<<<grid_size, block_size, shared_mem_size, stream>>>(device_w, aux_tensor, aux_size, tgt_dim_size);

//      if (!first_iter)
//      {
//        aux_free = device_w;
//        cudaCheck(cudaFree(aux_free));
//      }
//      device_w = aux_tensor;
//      Rdims.push_back(tgt_dim_size);
//      first_iter=false;
//    }

//    while (Ldims.size()<Rdims.size())
//    {
//      float tgt_dim_size = Rdims[Ldims.size()];
//      float aux_size = DimsProd(Ldims);
//      float *aux_tensor, *aux_free;
//      cudaMalloc(&aux_tensor, round_to_nearest_pow2(aux_size*tgt_dim_size)*sizeof(float));
//      cudaMemset(aux_tensor, 0, aux_size*tgt_dim_size*sizeof(float));
      
//      int grid_size = dims_prod;
//      int block_size = 32;
//      size_t shared_mem_size = 2 * block_size / 32 * sizeof(float);
//      repeat_interleave_kernel_last_dim<<<grid_size, block_size, shared_mem_size, stream>>>(device_x, aux_tensor, aux_size, tgt_dim_size);

//      if (!first_iter)
//      {
//        aux_free = device_x;
//        cudaCheck(cudaFree(aux_free));
//      }
//      device_x = aux_tensor;
      
//      Ldims.push_back(tgt_dim_size);
      
//      dims_prod = DimsProd(Ldims);
//      first_iter=false;
//    }
//  }


//  float *device_y = get_from_pool(scope_struct, thread_id, dims_prod, "hadamard");


//  int grid_size, block_size;
//  std::vector<int> grid_block_mem_sizes = CalculateGridAndBlockSizes(dims_prod);
//  grid_size = grid_block_mem_sizes[0];
//  block_size = grid_block_mem_sizes[1];

//  tensor_x->Sync();
//  tensor_w->Sync();
//  hadamard_kernel<<<grid_size, block_size, 0, stream>>>(device_y, device_x, device_w, dims_prod);
//  //PrintTensorF(device_y, 2, 2);



//  DT_tensor *new_tensor = createTensor(scope_struct, device_y, Ldims, dims_prod, false, "");
//  new_tensor->AttrNodes(tensor_x, tensor_w, hadamard_op);
//  return new_tensor;
//}



//extern "C" DT_tensor *tensor_tensor_div(Scope_Struct *scope_struct, DT_tensor *tensor_x, DT_tensor *tensor_w) {
                            
//  int thread_id = scope_struct->thread_id;
  
//  //std::cout << "TENSOR TENSOR DIV" << "\n";
  
//  std::vector<int> Ldims, Rdims;
//  Ldims = tensor_x->dims;
//  Rdims = tensor_w->dims;
//  float *device_x = tensor_x->tensor_ptr;
//  float *device_w = tensor_w->tensor_ptr;
//  float dims_prod, R_dims_prod;
//  dims_prod = tensor_x->dims_prod;
//  R_dims_prod = tensor_w->dims_prod;


//  cudaStream_t stream = ThreadsStream[thread_id];
//  if (Ldims!=Rdims) //Then broadcast
//  { //TODO: change kernel instead
//    bool first_iter = true;
//    while (Ldims.size()>Rdims.size())
//    {
//      float tgt_dim_size = Ldims[Rdims.size()];
//      float aux_size = DimsProd(Rdims);
//      float *aux_tensor, *aux_free;
//      cudaMalloc(&aux_tensor, round_to_nearest_pow2(aux_size*tgt_dim_size)*sizeof(float));
//      cudaMemset(aux_tensor, 0, aux_size*tgt_dim_size*sizeof(float));
      
//      int grid_size = dims_prod;
//      int block_size = 32;
//      size_t shared_mem_size = 2 * block_size / 32 * sizeof(float);
//      repeat_interleave_kernel_last_dim<<<grid_size, block_size, shared_mem_size, stream>>>(device_w, aux_tensor, aux_size, tgt_dim_size);

//      if (!first_iter)
//      {
//        aux_free = device_w;
//        cudaCheck(cudaFree(aux_free));
//      }
//      device_w = aux_tensor;
//      Rdims.push_back(tgt_dim_size);
//      first_iter=false;
//    }

//    while (Ldims.size()<Rdims.size())
//    {
//      float tgt_dim_size = Rdims[Ldims.size()];
//      float aux_size = DimsProd(Ldims);
//      float *aux_tensor, *aux_free;
//      cudaMalloc(&aux_tensor, round_to_nearest_pow2(aux_size*tgt_dim_size)*sizeof(float));
//      cudaMemset(aux_tensor, 0, aux_size*tgt_dim_size*sizeof(float));
      
//      int grid_size = dims_prod;
//      int block_size = 32;
//      size_t shared_mem_size = 2 * block_size / 32 * sizeof(float);
//      repeat_interleave_kernel_last_dim<<<grid_size, block_size, shared_mem_size, stream>>>(device_x, aux_tensor, aux_size, tgt_dim_size);

//      if (!first_iter)
//      {
//        aux_free = device_x;
//        cudaCheck(cudaFree(aux_free));
//      }
//      device_x = aux_tensor;
      
//      Ldims.push_back(tgt_dim_size);
      
//      dims_prod = DimsProd(Ldims);
//      first_iter=false;
//    }
//  }


//  //if (dims_prod!=R_dims_prod)
//  //  LogErrorC(scope_struct->code_line, "Tensors division has tensors of different dimensions.");


//  float* device_y = get_from_pool(scope_struct, thread_id, dims_prod,"div");
  


//  int grid_size = dims_prod;
//  int block_size = 32;
//  size_t shared_mem_size = 2 * block_size / 32 * sizeof(float);
//  tensor_div<<<grid_size, block_size, shared_mem_size, stream>>>(device_w, device_x, device_y, dims_prod);

//  DT_tensor *new_tensor = createTensor(scope_struct, device_y, Ldims, dims_prod, false, "");  
//  new_tensor->AttrNodes(tensor_x, tensor_w, div_op);
//  return new_tensor;
//}


//void hadamard_backward2(float *x, float *w, float *dx, float *dw, float *dy, float dims_prod)
//{
//  //std::cout << "hadamard_backward" <<  "\n";
//  int grid_size, block_size;
//  CalculateGridAndBlockSizes(dims_prod, grid_size, block_size);

//  hadamard_backward_kernel<<<grid_size, block_size, 0, main_stream>>>(x, w, dx, dw, dy, dims_prod);
//}


