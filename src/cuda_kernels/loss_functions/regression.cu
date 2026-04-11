#pragma once


#include "../../nsk_cuda/pool/include.h"
#include "../../tensor/include.h"
#include "../../cuda_threads/include.h"
#include "../activation_functions/include.h"
#include "../calculate_grids.h"
#include "../elementwise_kernels_inline.cu"
#include "regression_kernels.h"


extern "C" float mse_backward_kernel(Scope_Struct *scope_struct,
                 void *dloss,
                 void *y_hat, void *y,
                 int dims_prod) {
  //std::cout << "MSE Backward" << "\n";
  int tid = scope_struct->thread_id;
  cudaStream_t stream = ThreadsStream[tid];

  int grid_size, block_size, shared_mem_size;
  CalculateGridAndBlockSizes(dims_prod, grid_size, block_size);
  
  mse_kernel<<<grid_size, block_size, 0, stream>>>(*(float**)dloss, *(float**)y_hat, *(float**)y, dims_prod);
  return 0;
}

//extern "C" float mse(DT_tensor *y_hat, DT_tensor *y, float scale)
//{  
//  DT_tensor *loss_tensor = new DT_tensor();


//  loss_tensor->AttrNodes(y_hat, y, mse_op);
//  loss_tensor->scalar = scale;


//  todo_backward_tensors.push_back(loss_tensor);


//  return 0;
//}





//extern "C" DT_tensor *mse_with_priorities(Scope_Struct * scope_struct, int thread_id, DT_tensor *y_hat, DT_tensor *y, float scale, DT_tensor *is_w)
//{  
//  DT_tensor *mse_tensor, *loss_tensor;
//  mse_tensor = new DT_tensor();
//  loss_tensor = new DT_tensor();



  
//  mse_tensor->AttrNodes(y_hat, y, lgrad_op);
//  mse_tensor->scalar = scale;
//  mse_tensor->dims = y_hat->dims;
//  mse_tensor->dims_prod = y_hat->dims_prod;

//  loss_tensor->AttrNodes(mse_tensor, is_w, mse_is_w_op);
  

//  //loss_tensor->AttrNodes(y_hat, y, mse_op);



//  todo_backward_tensors.push_back(loss_tensor);


//  std::vector<int> dims = format_BatchFirst_Dims(y_hat->dims);
//  int B = dims[0];
//  int C = dims[1];


//  float *msed = get_from_pool(scope_struct, 0, B, "mse with priorities");

//  int grid_size, block_size;
//  std::vector<int> grid_block_mem_sizes = CalculateSimpleWarpGridAndBlockSizes(B);
//  grid_size = grid_block_mem_sizes[0];
//  block_size = grid_block_mem_sizes[1];
  

//  online_mse<<<grid_size, block_size, 0, main_stream>>>(msed, y_hat->tensor_ptr, y->tensor_ptr, B, C);

//  DT_tensor *new_tensor = createTensor(scope_struct, msed, {B}, B, false, "");
//  new_tensor->AttrLNode(y_hat, detach_op);
//  return new_tensor;
//}



//void MSEWithPrioritiesBackward(DT_tensor *loss_tensor,
//                 float *dloss)
//{
//  //std::cout << "MSEWithPriorities Backward" << "\n";

  
//  DT_tensor *y_hat_tensor, *y_tensor, *is_w_tensor;
//  y_hat_tensor = loss_tensor->L_Node->L_Node;
//  y_tensor = loss_tensor->L_Node->R_Node;
//  is_w_tensor = loss_tensor->R_Node;
//  float scale = loss_tensor->L_Node->scalar;

//  int dims_prod = y_hat_tensor->dims_prod;

//  int grid_size, block_size, shared_mem_size;
//  std::vector<int> grid_block_mem_sizes = CalculateGridAndBlockSizes(dims_prod);
//  grid_size  = grid_block_mem_sizes[0];
//  block_size = grid_block_mem_sizes[1];
  
//  //std::cout << "grid_size: " << grid_size << ", block_size: " << block_size << "\n";
//  mse_with_priorities_kernel<<<grid_size, block_size, 0, main_stream>>>(dloss, y_hat_tensor->tensor_ptr, y_tensor->tensor_ptr, is_w_tensor->tensor_ptr, scale, dims_prod);

//  //PrintTensorF(dloss, 1, dims_prod);
//}
