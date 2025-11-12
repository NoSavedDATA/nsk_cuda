
#include "../../../../src/nsk_cpp.h"
#include "../common/cu_commons.h"
#include "../backprop/backprop.h"


std::map<std::string, std::function<void(void *)>> infer_mode_fn;
std::map<std::string, std::function<void(void *)>> train_mode_fn;


extern "C" float eval(Scope_Struct *scope_struct)
{
  std::cout << "\n\n\nSETTING NN MODE TO EVAL" << "\n\n";
    
  for (auto& pair : NamedParamGrads)
  {
    std::cout << "Erasing gradient memory of: " << pair.first << "\n";
    cudaCheck(cudaFree(pair.second));
  }

  NamedParamGrads.clear();

  // Todo: clean optimizer grads
  // for (auto &pair: optimizer->NamedV)
  //   cudaCheck(cudaFree(pair.second));
    
  // for (auto &pair: optimizer->NamedM)
  //   cudaCheck(cudaFree(pair.second));  

  nn_mode = eval_mode;

  std::cout << "\n\n\n";
  return 0;
}





void set_train_worklist(Scope_Struct *scope_struct, void *obj_ptr, std::string obj_type) {
  for (int i=0; i<ClassPointers[obj_type].size(); ++i) {
    std::string nested_type = ClassPointersType[obj_type][i];
    int offset = ClassPointers[obj_type][i];
    
    void **slot = (void **)(static_cast<char*>(obj_ptr)+offset);
    
    if (ClassPointers.count(nested_type)>0)
      set_train_worklist(scope_struct, *slot, nested_type);

    
    if (train_mode_fn.count(nested_type)&&check_initialized_field((char*)obj_ptr + offset))
      train_mode_fn[nested_type](*slot);

  }
}

extern "C" float train_mode(Scope_Struct *scope_struct, void *obj_ptr)
{
  for (const GC_Node &node : scope_struct->gc.pointer_nodes) {
    if (node.ptr==obj_ptr) {
      for (int i=0; i<ClassPointers[node.type].size(); ++i) {
        std::string obj_type = ClassPointersType[node.type][i];
        int offset = ClassPointers[node.type][i];

        void **slot = (void **)(static_cast<char*>(obj_ptr)+offset);
        
        if (ClassPointers.count(obj_type)>0)
          set_train_worklist(scope_struct, *slot, obj_type);

        if (train_mode_fn.count(obj_type)&&check_initialized_field((char*)obj_ptr + offset))
          train_mode_fn[obj_type](*slot);
      }
      break;
    }
  }
  return 0;
}




void set_infer_worklist(Scope_Struct *scope_struct, void *obj_ptr, std::string obj_type) {
  for (int i=0; i<ClassPointers[obj_type].size(); ++i) {
    std::string nested_type = ClassPointersType[obj_type][i];
    int offset = ClassPointers[obj_type][i];
    
    void **slot = (void **)(static_cast<char*>(obj_ptr)+offset);
    
    if (ClassPointers.count(nested_type)>0)
      set_infer_worklist(scope_struct, *slot, nested_type);

    if (infer_mode_fn.count(nested_type)&&check_initialized_field((char*)obj_ptr + offset))
      infer_mode_fn[nested_type](*slot);

  }
}

extern "C" float infer_mode(Scope_Struct *scope_struct, void *obj_ptr)
{
  Scope_Struct *inner_most = get_inner_most_scope(scope_struct);
  for (const GC_Node &node : inner_most->gc.pointer_nodes) {
    if (node.ptr==obj_ptr) {
      for (int i=0; i<ClassPointers[node.type].size(); ++i) {
        std::string obj_type = ClassPointersType[node.type][i];
        int offset = ClassPointers[node.type][i];

        void **slot = (void **)(static_cast<char*>(obj_ptr)+offset);
        
        if (ClassPointers.count(obj_type)>0)
          set_infer_worklist(scope_struct, *slot, obj_type);

        if (infer_mode_fn.count(obj_type)&&check_initialized_field((char*)obj_ptr + offset))
          infer_mode_fn[obj_type](*slot);
      }
      break;
    }
  }
  return 0;
}