
#include<string>
#include<vector>
#include<map>
#include<cstring>
#include<random>
#include<thread>
#include<cstdarg>

#include "../pool/include.h"
#include "../common/cu_commons.h"
#include "../cuda_kernels/calculate_grids.h"
#include "../cuda_kernels/elementwise_kernels_inline.cu"
#include "../nsk_cuda/pool/include.h"
#include "../tensor/include.h"
#include "../../src/nsk_cpp.h"
#include "include.h"


extern "C" void *zeros_cuda_pool(Scope_Struct *scope_struct, int size){
    void **ptr = (void**)allocate_pool(scope_struct, 8, data_name_to_type()["float_pp"]);
    float *tensor_cpu = make_zeros_float(size);

    float *tensor_ptr = tarena.Allocate<float>(size);
    cudaCheck(cudaMemcpy(tensor_ptr, tensor_cpu, size*4, cudaMemcpyHostToDevice));
    free(tensor_cpu);
    *ptr = tensor_ptr;
    return (void*)ptr;
}



extern "C" void *randu_cpu(Scope_Struct *scope_struct, int size){
    void **ptr = (void**)allocate<char>(scope_struct, 8, "float_pp");
    float *tensor_cpu = make_random_float_uniform(size);
    *ptr = tensor_cpu;
    return (void*)ptr;
}
extern "C" void *xavu_cuda(Scope_Struct *scope_struct, int size, int m, int n){
    void **ptr = (void**)allocate<char>(scope_struct, 8, "float_pp");
    float *tensor_cpu = make_xavier_uniform_float(size, m, n);

    float *tensor_ptr;
    cudaMalloc(&tensor_ptr, size*4);
    // float *tensor_ptr = tarena.Allocate<float>(size);
    cudaCheck(cudaMemcpy(tensor_ptr, tensor_cpu, size*4, cudaMemcpyHostToDevice));
    free(tensor_cpu);
    *ptr = tensor_ptr;
    return (void*)ptr;
}
extern "C" void *randu_cuda(Scope_Struct *scope_struct, int size){
    void **ptr = (void**)allocate<char>(scope_struct, 8, "float_pp");
    float *tensor_cpu = make_random_float_uniform(size);

    float *tensor_ptr;
    cudaMalloc(&tensor_ptr, size*4);
    // float *tensor_ptr = tarena.Allocate<float>(size);
    cudaCheck(cudaMemcpy(tensor_ptr, tensor_cpu, size*4, cudaMemcpyHostToDevice));
    free(tensor_cpu);
    *ptr = tensor_ptr;
    return (void*)ptr;
}
extern "C" void *zeros_cuda(Scope_Struct *scope_struct, int size){
    void **ptr = (void**)allocate_pool(scope_struct, 8, data_name_to_type()["float_pp"]);
    float *tensor_cpu = make_zeros_float(size);

    float *tensor_ptr;
    cudaMalloc(&tensor_ptr, size*4);
    cudaCheck(cudaMemcpy(tensor_ptr, tensor_cpu, size*4, cudaMemcpyHostToDevice));
    free(tensor_cpu);
    *ptr = tensor_ptr;
    return (void*)ptr;
}
extern "C" void *ones_cuda(Scope_Struct *scope_struct, int size){
    void **ptr = (void**)allocate<char>(scope_struct, 8, "float_pp");
    float *tensor_cpu = make_ones_float(size);

    float *tensor_ptr;
    cudaMalloc(&tensor_ptr, size*4);
    cudaCheck(cudaMemcpy(tensor_ptr, tensor_cpu, size*4, cudaMemcpyHostToDevice));
    free(tensor_cpu);
    *ptr = tensor_ptr;
    return (void*)ptr;
}


extern "C" void *randu_bf16_cuda(Scope_Struct *scope_struct, int size){
    void **ptr = (void**)allocate<char>(scope_struct, 8, "bf16_pp");
    uint16_t *tensor_cpu = make_random_bf16_uniform(size);

    uint16_t *tensor_ptr;
    cudaMalloc(&tensor_ptr, size*2);
    // float *tensor_ptr = tarena.Allocate<float>(size);
    cudaCheck(cudaMemcpy(tensor_ptr, tensor_cpu, size*2, cudaMemcpyHostToDevice));
    free(tensor_cpu);
    *ptr = tensor_ptr;
    return (void*)ptr;
}
extern "C" void *zeros_bf16_cuda(Scope_Struct *scope_struct, int size){
    void **ptr = (void**)allocate_pool(scope_struct, 8, data_name_to_type()["bf16_pp"]);
    uint16_t *tensor_cpu = make_zeros_bf16(size);

    uint16_t *tensor_ptr;
    cudaMalloc(&tensor_ptr, size*2);
    cudaCheck(cudaMemcpy(tensor_ptr, tensor_cpu, size*2, cudaMemcpyHostToDevice));
    free(tensor_cpu);
    *ptr = tensor_ptr;
    return (void*)ptr;
}





extern "C" void *xavu_conv(Scope_Struct *scope_struct, int m, int n, int ks, int ks2, int dims_prod) {
    void **ptr = (void**)allocate<char>(scope_struct, 8, "float_pp");
    float *tensor_cpu = make_xavier_uniform_float(dims_prod, m, n);

    float *tensor_ptr;
    cudaMalloc(&tensor_ptr, dims_prod*4);


    std::vector<float> h_filter;
    float *filter;
    for (std::size_t idx = 0; idx < m * n; ++idx) {
        // if (Init=="xavu_relu")
         filter = make_xavier_uniform_float_relu(ks*ks, ks*ks*m, ks*ks*n);
        // if (Init == "xavu_tanh")
        //  filter = make_xavier_uniform_float_tanh(ks*ks, ks*ks*m, ks*ks*n);
        // if (Init=="he_normal_relu")
        //  filter = make_he_normal_float_relu(ks*ks, ks*ks*m);
        // if (Init == "init_gpt")
        //  filter = make_gpt_init(ks*ks);
        // if (Init=="xavu")
        //  filter = make_xavier_uniform_float(ks*ks, ks*ks*m, ks*ks*n);
        // if (Init=="zeros")
        //  filter = make_zeros_float(ks*ks);
        // if (Init=="ones")
        //  filter = make_ones_float(ks*ks);
        // if (Init=="randu")
        //  filter = make_random_float_uniform(ks*ks);

        for (int i=0; i < ks*ks; i++)
         h_filter.emplace_back(filter[i]);

        delete[] filter;
        //for (const auto& val : filter) 
        //  h_filter.emplace_back(val);
    }

    cudaCheck(cudaMemcpy(tensor_ptr, h_filter.data(), dims_prod * sizeof(float), cudaMemcpyDefault));
  








    // float *tensor_ptr = tarena.Allocate<float>(size);
    cudaCheck(cudaMemcpy(tensor_ptr, tensor_cpu, dims_prod*4, cudaMemcpyHostToDevice));
    free(tensor_cpu);
    *ptr = tensor_ptr;
    return (void*)ptr;
}

extern "C" void float_pp_Clean_Up(void *ptr, int tid) {
    // std::cout << "" << ptr << "\n";
    // float *fptr = *(float**)ptr;
    // if (fptr)
    //     cudaFree(fptr);
}
extern "C" void float_cpu_Clean_Up(void *ptr, int tid) {
    // std::cout << "float cpu" << ptr << "\n";
    float *fptr = *(float**)ptr;
    if (fptr)
        cudaFree(fptr);
}


//extern "C" DT_tensor *tensor_Create(Scope_Struct *scope_struct, char *init, int first_dim, ...)
//{
//    int thread_id = scope_struct->thread_id;

//    // todo: handle is_weight argument
//    bool is_weight = false;

//    // Get dimensions
//    std::vector<int> dims;
//    va_list args;
//    va_start(args, first_dim);
//    int dim = first_dim; 
//    int i=0;
//    do {
//        dims.push_back(dim);
//        dim = va_arg(args, int);
//        ++i;
//    } while (dim!=TERMINATE_VARARG&&i<10);
//    va_end(args);

    
//    DT_tensor *tensor;

//    int product = DimsProd(dims);

//    float *tensor_ptr;
//    float *tensor_cpu;


//    if(product>0)
//    {
//      if (std::strcmp(init, "randu") == 0)
//        tensor_cpu = make_random_float_uniform(product);
//      if (std::strcmp(init, "zeros") == 0)
//        tensor_cpu = make_zeros_float(product);
//      if (std::strcmp(init, "ones") == 0)
//        tensor_cpu = make_ones_float(product);
//      if (std::strcmp(init, "normal") == 0)
//        tensor_cpu = make_normal(product);
//      if (std::strcmp(init, "xavu") == 0)
//        tensor_cpu = make_xavier_uniform_float(product, dims[dims.size()-1], dims[dims.size()-2]);
//      if (std::strcmp(init, "fixed8i") == 0)
//        tensor_cpu = make_xavier_uniform_float_fixed(product, dims[dims.size()-1], dims[dims.size()-2], 8);
//      if (std::strcmp(init, "fixed42i") == 0)
//        tensor_cpu = make_xavier_uniform_float_fixed(product, dims[dims.size()-1], dims[dims.size()-2], 42);
//      if (std::strcmp(init, "xavu_relu") == 0)
//        tensor_cpu = make_xavier_uniform_float_relu(product, dims[dims.size()-1], dims[dims.size()-2]);
//      if (std::strcmp(init, "xavu_tanh") == 0)
//        tensor_cpu = make_xavier_uniform_float_tanh(product, dims[dims.size()-1], dims[dims.size()-2]);
//      if (std::strcmp(init, "he_normal_relu") == 0)
//        tensor_cpu = make_he_normal_float_relu(product, dims[dims.size()-1]);
//      if (std::strcmp(init, "init_gpt") == 0)
//        tensor_cpu = make_gpt_init(product);
//      if (std::strcmp(init, "ints") == 0)
//        tensor_cpu = make_random_int(product, 10);
//      if (std::strcmp(init, "bernoulli") == 0)
//        tensor_cpu = make_random_int(product, 2);
//      if (std::strcmp(init, "arange") == 0)
//        tensor_cpu = make_arange(product);
//      if (std::strcmp(init, "binary") == 0)
//        tensor_cpu = make_random_int(product, 1);
  
//      cudaCheck(cudaGetLastError());
//      std::string _name = "create tensor ";
//      tensor_ptr = get_from_pool(scope_struct, thread_id, product, "tensor_Create");
  
//      cudaStream_t stream = ThreadsStream[thread_id];
//      cudaCheck(cudaMemcpyAsync(tensor_ptr, tensor_cpu, product*sizeof(float), cudaMemcpyHostToDevice, stream));
//      //cudaStreamSynchronize(stream);
//      delete[] tensor_cpu;
//  }
    

//    tensor = createTensor(scope_struct, tensor_ptr, dims, product, true, "tensor_Create");
//    tensor->scopeless_name = "tensor_Create";
//    if(is_weight)
//      tensor->SetIsWeight();
//    tensor->op = create_tensor_op;

   

//  std::cout << "return tensor: " << tensor << "\n";

//  return tensor;
//}










//extern "C" DT_tensor *tensor_Copy(Scope_Struct *scope_struct, DT_tensor *tensor) {

//  if(!tensor->leaf)
//    return tensor;

//  int thread_id = scope_struct->thread_id;

//  std::string tensor_name = tensor->name;
  
//  // std::string arg_tensor_name = "list_" + tensor_name;
//  std::string arg_tensor_name = tensor_name;
  

//  std::vector<int> dims = tensor->dims;
//  int dims_prod = tensor->dims_prod;

//  float *arg_tensor, *tensor_ptr;

//  tensor_ptr = tensor->tensor_ptr;

//  std::string where_from = "tensor copy of ";
//  where_from = where_from + tensor_name;
//  arg_tensor = get_from_pool(scope_struct, thread_id, dims_prod, where_from);
  
  
//  if (dims_prod!=0)
//  {
//    int grid_size, block_size;
//    CalculateGridAndBlockSizes(tensor->dims_prod, grid_size, block_size);

//    tensor->Sync();

//    cudaStream_t stream = ThreadsStream[thread_id];
//    copy_tensor_kernel<<<grid_size,block_size,0,stream>>>(arg_tensor, tensor_ptr, dims_prod);
//  }
  

//  DT_tensor *new_tensor = createTensor(scope_struct, arg_tensor, dims, dims_prod, true, arg_tensor_name, tensor->cuda_stream, tensor->loader);
//  new_tensor->scopeless_name = tensor->scopeless_name;
//  set_grad_candidate(scope_struct, new_tensor, tensor->is_grad_candidate);

  

//  return new_tensor;
//}









//inline void create_backward_tensor(Scope_Struct *scope_struct, std::string scopeless_name, DT_tensor *tensor) {
//  todo_backward_tensors.push_back( createBackward(scope_struct, scopeless_name, tensor) );
//}





//extern "C" void *tensor_StoreTrigger(Scope_Struct *scope_struct, DT_tensor *stored_tensor, DT_tensor *tensor)
//{
//  std::string tensor_name = "old tensor";
//  // std::cout << "tensor_StoreTrigger overwriting: " << stored_tensor << ".\n";
//  // std::cout << "tensor_StoreTrigger new: " << tensor << ".\n";
//  std::string scopeless_name = stored_tensor->scopeless_name;
//  bool is_grad_candidate = tensor->is_grad_candidate;

//  char *scope = scope_struct->scope;
//  int thread_id= scope_struct->thread_id;
//  int has_grad = scope_struct->has_grad;

//  stored_tensor->is_last_version = false;

//  // View op
//  if (tensor->view_of == tensor_name) {
//    stored_tensor->dims = tensor->dims;
//    tensor = stored_tensor;
//  }
//  else
//  {
//    //todo: handle residual/copy tensor backprop cut    
//    if(is_grad_candidate&&thread_id==0) {
//      create_backward_tensor(scope_struct, scopeless_name, tensor);
//      tensor = createTensor(scope_struct, tensor->tensor_ptr, tensor->dims, tensor->dims_prod, true, tensor_name, stored_tensor->cuda_stream, stored_tensor->loader);
//      set_grad_candidate(scope_struct, tensor, is_grad_candidate);
//    }
//  }
//  tensor->scopeless_name = scopeless_name;
//  tensor->thread_id = thread_id;
//  tensor->is_last_version = true;
  
//  cudaCheck(cudaGetLastError());

//  return tensor;
//}

//extern "C" float tensor_has_grad(Scope_Struct *scope_struct, DT_tensor *tensor) {
//  std::cout << "--> tensor " << tensor->scopeless_name << " HAS GRAD: " << tensor->is_grad_candidate << ".\n";
//  return 0;
//}


//extern "C" void tensor_Clean_Up(void *data_ptr) {
//  // std::cout << "tensor_Clean_Up" << ".\n";
  
//  DT_tensor *tensor = (DT_tensor*) data_ptr;
//  // PrintDims(tensor->dims);
//  // if(tensor->thread_id!=0)
//  //   printf("----------Cleaning tensor from thread %d\n", tensor->thread_id);


//  if (!(tensor->is_grad_candidate||tensor->parent_is_grad_candidate))
//  {
//    // if (tensor->scopeless_name=="y") {
//    //   std::cout << "clean up of: " << tensor->scopeless_name << "/" << tensor << ".\n";
//    //   PrintDims(tensor->dims);
//    // }

//    if(tensor->op!=view_op)
//      move_to_pool(tensor->thread_id, tensor->dims_prod, tensor->tensor_ptr, "tensor_Clean_Up");
//  }
//}





//extern "C" DT_tensor *gpu(Scope_Struct *scope_struct, DT_tensor *tensor, DT_tensor *pinned_tensor)
//{
//  // //std::cout << "\nGpu transfer for: " << tensor.name << " on worker " << idx << "\n";
//  // int thread_id = scope_struct->thread_id; 
//  // float *tensor_ptr, *tensor_cpu;
  
//  // tensor_cpu = pinned_tensor->cpu_tensor_ptr;
//  // std::vector<int> dims = pinned_tensor->dims;
//  // float dims_prod = pinned_tensor->dims_prod;
  
//  // if (tensor->dims_prod==dims_prod)
//  //   tensor_ptr = tensor->tensor_ptr;
//  // else
//  //   tensor_ptr = get_from_pool(scope_struct, thread_id, dims_prod, "gpu");
  
//  // //tensor_ptr = get_from_pool(scope_struct, dims_prod, "gpu");
  
//  // Loader *loader=nullptr;
//  // cudaStream_t cuda_stream = createCudaStream();
//  // cudaMemcpyAsync(tensor_ptr, tensor_cpu, dims_prod * sizeof(float), cudaMemcpyHostToDevice, cuda_stream);
//  // //cudaMemcpy(tensor_ptr, tensor_cpu, dims_prod * sizeof(float), cudaMemcpyHostToDevice);
//  // pinned_tensor->cuda_stream = cuda_stream;

//  //   DT_tensor *attr_tensor;
//  //   attr_tensor = createTensor(scope_struct, tensor_ptr, dims, dims_prod, true, "");
//  //   attr_tensor->op = gpu_op;
//  //   todo_backward_tensors.push_back(attr_tensor); // pass to gc

//  // tensor->AttrTensor(tensor_ptr, dims, dims_prod, cuda_stream, loader);
//  return tensor;
//}



//extern "C" DT_tensor *tensor_gpuw(Scope_Struct *scope_struct, DT_tensor *tensor, DT_tensor *pinned_tensor, int idx)
//{
//  int thread_id = scope_struct->thread_id;
//  float *tensor_ptr, *tensor_cpu;

//  std::vector<int> dims, batchless_dims;
//  dims = pinned_tensor->dims;
//  batchless_dims = BatchLessDims(dims);
//  float batchless_dims_prod = (float)DimsProd(batchless_dims);

//  tensor_cpu = pinned_tensor->cpu_tensor_ptr + static_cast<int>(idx*batchless_dims_prod);


//  if(!tensor->is_grad_candidate&&tensor->dims_prod!=0)
//    move_to_pool(thread_id, tensor->dims_prod, tensor->tensor_ptr, "gpuw");

  
//  tensor_ptr = get_from_pool(scope_struct, thread_id, batchless_dims_prod, "gpuw");

//  Loader *loader=nullptr;
//  cudaStream_t cuda_stream = nullptr;
  
//  if (batchless_dims_prod<2000){
//    cudaMemcpy(tensor_ptr, tensor_cpu, batchless_dims_prod * sizeof(float), cudaMemcpyHostToDevice);
//  }
//  else// if (batchless_dims_prod<1000)
//  {
//    cuda_stream = createCudaStream();
//    // cudaMemcpyAsync(tensor_ptr, tensor_cpu, batchless_dims_prod * sizeof(float), cudaMemcpyHostToDevice, cuda_stream);
//    cudaMemcpy(tensor_ptr, tensor_cpu, batchless_dims_prod * sizeof(float), cudaMemcpyHostToDevice);
//    pinned_tensor->cuda_stream = cuda_stream;
//  }
//  /*
//  else
//  {
//    //cuda_stream = AllocateStream(0);
//    //cudaMemcpyAsync(tensor_ptr, tensor_cpu, batchless_dims_prod * sizeof(float), cudaMemcpyHostToDevice, cuda_stream);
//    loader = new Loader();
//    loader->Load(tensor_ptr, tensor_cpu, batchless_dims_prod);
//  }
//  */

//  tensor->AttrTensor(tensor_ptr, batchless_dims, batchless_dims_prod, cuda_stream, loader);
//  tensor->leaf=true;

//  return tensor;
//}


//extern "C" float cpu(Scope_Struct *scope_struct, DT_tensor *tensor)
//{
//  int thread_id = scope_struct->thread_id; 

//  float *tensor_ptr, *tensor_cpu;
//  tensor_ptr = tensor->tensor_ptr;
//  tensor_cpu = tensor->cpu_tensor_ptr;

//  cudaStream_t stream = ThreadsStream[thread_id];
//  cudaStreamSynchronize(stream);

//  if (tensor_ptr==nullptr)
//    LogErrorC(scope_struct->code_line, "Cannot load tensor to cpu from an null tensor.");

//  if (tensor_cpu!=nullptr)
//    cudaCheck(cudaFree(tensor_cpu));

//  float dims_prod = tensor->dims_prod;



//  cudaMallocHost(&tensor_cpu, round_to_nearest_pow2(dims_prod)*sizeof(float));
//  cudaMemcpy(tensor_cpu, tensor_ptr, dims_prod*sizeof(float), cudaMemcpyDeviceToHost);

//  tensor->cpu_tensor_ptr = tensor_cpu;


//  return 0;
//}

//extern "C" float cpu_idx(Scope_Struct *scope_struct, DT_tensor *tensor, float idx)
//{

//  float *tensor_cpu;
//  tensor_cpu = tensor->cpu_tensor_ptr;


//  if (tensor_cpu==nullptr)
//    LogErrorC(scope_struct->code_line, "Cannot idx a null cpu tensor.");

//  float dims_prod = tensor->dims_prod;
//  if (idx>dims_prod)
//    LogErrorC(scope_struct->code_line, "Idx higher than dims prod at cpu_idx().");

  

//  return tensor_cpu[(int)idx];
//}


//extern "C" DT_tensor *randu_like(Scope_Struct *scope_struct, DT_tensor tensor)
//{
//  int thread_id = scope_struct->thread_id;

//  float dims_prod = tensor.dims_prod;

//  float *tensor_ptr, *tensor_cpu;

//  tensor_cpu = make_random_float_uniform(dims_prod);

//  cudaStream_t stream = ThreadsStream[thread_id];
//  cudaMalloc(&tensor_ptr, round_to_nearest_pow2(dims_prod)*sizeof(float));
//  cudaMemcpyAsync(tensor_ptr, tensor_cpu, dims_prod*sizeof(float), cudaMemcpyHostToDevice, stream);
//  delete[] tensor_cpu;

//  DT_tensor *new_tensor = createTensor(scope_struct, tensor_ptr, tensor.dims, dims_prod, false, "");
//  new_tensor->op = randu_like_op;
//  return new_tensor;
//}



//void copyChunk(float* d_data, const float* h_data, int offset, float size, cudaStream_t stream) {
//  cudaMemcpyAsync(d_data + offset, h_data + offset, size*sizeof(float), cudaMemcpyHostToDevice, stream);
//}


//extern "C" float write_zerosw(Scope_Struct *scope_struct, DT_tensor *tensor, int worker_idx)
//{
//  std::vector<int> dims = tensor->dims;

//  std::vector<int> workerless_dims = BatchLessDims(dims);
//  int workerless_dims_prod = DimsProd(workerless_dims);

//  int idx_offset =  workerless_dims_prod*worker_idx;

//  for(int i=0; i<workerless_dims_prod; i++)
//    tensor->cpu_tensor_ptr[i+idx_offset] = 0.0f;
  
//  return 0;
//}
















//extern "C" DT_tensor *zeros_like(Scope_Struct *scope_struct, DT_tensor *tensor) {

//  // DT_tensor *zeros_tensor = new DT_tensor();

//  int thread_id = scope_struct->thread_id;
//  float *tensor_ptr = tensor->tensor_ptr;
//  std::vector<int> dims = tensor->dims;
//  int dims_prod = tensor->dims_prod;

//  int grid_size, block_size; 
//  CalculateGridAndBlockSizes(dims_prod, grid_size, block_size);

//  float *y = get_from_pool(scope_struct, thread_id, dims_prod, "relu");


//  tensor->Sync();
//  cudaStream_t stream = ThreadsStream[thread_id];
//  set_to_zero_kernel<<<grid_size, block_size, 0, stream>>>(y, dims_prod);

//  return customOpTensor(scope_struct, y, dims, DimsProd(dims), "set_to_zero", nullptr, tensor, false);
//}






//extern "C" void *tensor_CopyArg(Scope_Struct *scope_struct, DT_tensor *tensor, char *new_tensor_name)
//{ 
//  int thread_id = scope_struct->thread_id;
//  std::string tensor_name = tensor->name;
    
//  std::vector<int> dims = tensor->dims;
//  int dims_prod = tensor->dims_prod;
    
//  float *tensor_ptr = get_from_pool(scope_struct, thread_id, dims_prod, "copy_arg");
//  if (dims_prod!=0)
//  {
//    int grid_size, block_size;
//    CalculateGridAndBlockSizes(tensor->dims_prod, grid_size, block_size);

//    tensor->Sync();

//    cudaStream_t stream = ThreadsStream[thread_id];
//    copy_tensor_kernel<<<grid_size,block_size,0,stream>>>(tensor_ptr, tensor->tensor_ptr, dims_prod);
//  }
  

//  DT_tensor *new_tensor = createTensor(scope_struct, tensor_ptr, dims, dims_prod, true, tensor->name, tensor->cuda_stream, tensor->loader);
//  set_grad_candidate(scope_struct, new_tensor, tensor->is_grad_candidate);
//  new_tensor->scopeless_name = tensor->scopeless_name;
//  return new_tensor;
//}





//extern "C" float tensor_print(Scope_Struct *scope_struct, DT_tensor *tensor) {
//  PrintTensor(scope_struct, tensor);
//  return 0;
//}


//extern "C" float tensor_spec(Scope_Struct *scope_struct, DT_tensor *tensor) {
//  std::cout << "tensor: " << tensor->scopeless_name << " / " << tensor << ".\n";
//  PrintDims(tensor->dims);
//  return 0;
//}


//extern "C" void tensor_set(Scope_Struct *scope_struct, DT_tensor *tensor, DT_tensor *arg_tensor) {
//    tensor->tensor_ptr = arg_tensor->tensor_ptr;
//    tensor->dims = arg_tensor->dims;
//    tensor->dims_prod = arg_tensor->dims_prod;
//}
