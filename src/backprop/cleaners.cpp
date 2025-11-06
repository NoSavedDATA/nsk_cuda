
#include "../nsk_cuda/pool/include.h"
#include "../nsk_cuda/utils/include.h"
#include "cleaners.h"

#include "include.h"



// Cleaners
std::map<std::string, float *> var_to_grad;
std::vector<std::tuple<int, float *, std::string>> backprop_tensors_to_pool;
std::vector<float *> tensors_sent_to_pool;
std::vector<DT_tensor *> backprop_Tensors_to_free;
std::vector<DT_tensor *> backprop_Tensors_to_save;

std::map<std::string, std::vector<std::tuple<int, float*,std::string>>> forward_tensors_to_pool;
std::map<std::string, std::vector<float*>> forward_tensors_sent_to_pool;
std::map<std::string, std::map<std::string, float*>> scope_tensors; // records last version of a tensor //todo: is this one actually used?

std::map<int, std::map<std::string, std::vector<std::tuple<int, float*,std::string>>>> threaded_tensors_to_pool;
std::map<int, std::map<std::string, std::vector<float*>>> threaded_tensors_sent_to_pool;
std::map<int, std::map<std::string, std::vector<DT_tensor*>>> threaded_Tensors_to_free;
std::map<int, std::map<std::string, std::vector<float*>>> threaded_tensors_to_save;
std::map<int, std::map<std::string, std::vector<DT_tensor*>>> threaded_Tensors_to_save;

void to_free_tensor(DT_tensor *tensor_ptr)
{
  if(!in_tensor_ptr_vec(tensor_ptr, backprop_Tensors_to_free))
    backprop_Tensors_to_free.push_back(tensor_ptr);
}
void to_pool(int dims_prod, float *tensor_ptr, std::string from)
{
  if (!in_float_ptr_vec(tensor_ptr, tensors_sent_to_pool))
  {
    backprop_tensors_to_pool.push_back(std::make_tuple(dims_prod, tensor_ptr, from));
    tensors_sent_to_pool.push_back(tensor_ptr);
  }
}
void save_from_pool(DT_tensor *tensor_ptr)
{
  if(!in_tensor_ptr_vec(tensor_ptr, backprop_Tensors_to_save))
    backprop_Tensors_to_save.push_back(tensor_ptr);
}






void CleanTree_Backprop(DT_tensor *back_node) {
  // Avoid calling CleanTree separatly. As this has the overhead of going throughout the tree multiple times.
  if (back_node==nullptr)
    return;
  // if(!back_node->is_grad_candidate)
  //   printf("--------------------------------------------\nAVOID BACKPROP TREE CLEAN CAUSE NOT GRAD\n");

  // if (back_node->weight||!back_node->is_grad_candidate)
  if (back_node->weight)
    return;
  


  CleanTree_Backprop(back_node->L_Node);
  CleanTree_Backprop(back_node->R_Node);

  float dims_prod = back_node->dims_prod;
  to_pool(dims_prod, back_node->tensor_ptr, "CleanTree leaf tensor"); 

  if (!back_node->is_last_version && (back_node->is_grad_candidate&&back_node->parent_is_grad_candidate))
    to_free_tensor(back_node);
}

