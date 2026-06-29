#include "initialize.h"

llvm::Type *float_pp_llvm(std::unique_ptr<LLVMContext> &ctx) {
    return Type::getFloatTy(*ctx)->getPointerTo();
}
llvm::Type *float_cpu_llvm(std::unique_ptr<LLVMContext> &ctx) {
    return Type::getFloatTy(*ctx)->getPointerTo();
}
llvm::Type *bf16_pp_llvm(std::unique_ptr<LLVMContext> &ctx) {
    return Type::getInt16Ty(*ctx)->getPointerTo();
}
llvm::Type *bf16_cpu_llvm(std::unique_ptr<LLVMContext> &ctx) {
    return Type::getInt16Ty(*ctx)->getPointerTo();
}


extern "C" void initialize__nsk_cuda() {
  for (int i=0;i<10;++i) {
    cudaStream_t thread_stream = createCudaStream();
    ThreadsStream[i] = thread_stream;
  }
  
  int deviceIdx = 0;
  cudaCheck(cudaSetDevice(deviceIdx));
  cudaGetDeviceProperties(&deviceProp, deviceIdx);

  std::cout << "\n\n";
  std::cout << "CuDNN Version: " << CUDNN_MAJOR << "." << CUDNN_MINOR << "." << CUDNN_PATCHLEVEL << std::endl;
  printf("Device %d: %s\n", deviceIdx, deviceProp.name);
  std::cout << "Device Max Compute Capability (SM): " << deviceProp.major << "." << deviceProp.minor << std::endl;

  std::cout << "Shared-Memory per thread-block size: " << deviceProp.sharedMemPerBlock << ".\n";
  
  for (int i=0; i<TSPANS; ++i) {
      tarena.cur_span[i] = nullptr;
      tarena.first_span[i] = nullptr;
  }

    
  cudaDeviceGetAttribute(&WARP_SIZE, cudaDevAttrWarpSize, 0); 
  cublasCheck(cublasCreate(&cublas_handle));
  cublasCheck(cublasLtCreate(&cublaslt_handle));


  int enable_tf32 = deviceProp.major >= 8 ? 1 : 0;


  printf("enable_tf32: %d\n", enable_tf32);
  
  cublas_compute_type = enable_tf32 ? CUBLAS_COMPUTE_32F_FAST_TF32 : CUBLAS_COMPUTE_32F;
  cublasMath_t cublas_math_mode = enable_tf32 ? CUBLAS_TF32_TENSOR_OP_MATH : CUBLAS_DEFAULT_MATH;
  cublasCheck(cublasSetMathMode(cublas_handle, cublas_math_mode));
  // setup the (global) cuBLASLt workspace
  cudaCheck(cudaMalloc(&cublaslt_workspace, cublaslt_workspace_size));
  
  cudnnCreate(&cudnn);

  std::cout << "Tile size is: " << TILE_SIZE << ".\n\n";
  main_stream = createCudaStream();



  // backward_functions["scalarmult_backward"] = scalarmult_backward;
  // backward_functions["relu_backward"] = relu_backward;
  // backward_functions["gelu_backward"] = gelu_backward;
  // backward_functions["sigmoid_backward"] = sigmoid_backward;
  // backward_functions["tanh_backward"] = tanh_backward;
  // backward_functions["mean_over_semilast_dim_backward"] = mean_over_semilast_dim_backward;
  // backward_functions["gather_last_dim_backward"] = gather_last_dim_backward;
  data_register_fn["float_pp"] = float_pp_llvm;
  data_register_fn["float_cpu"] = float_cpu_llvm;
  data_register_fn["bf16_pp"] = bf16_pp_llvm;
  data_register_fn["bf16_cpu"] = bf16_cpu_llvm;
}
