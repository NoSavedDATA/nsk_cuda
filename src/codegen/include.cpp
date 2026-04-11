
#include "../../../../src/nsk_cpp.h"
#include "../common/cu_commons.h"


std::map<std::string, std::function<void(void *)>> infer_mode_fn;
std::map<std::string, std::function<void(void *)>> train_mode_fn;


// void set_train_worklist(Scope_Struct *scope_struct, void *obj_ptr, std::string obj_type) {
//   for (int i=0; i<ClassPointers[obj_type].size(); ++i) {
//     std::string nested_type = ClassPointersType[obj_type][i];
//     int offset = ClassPointers[obj_type][i];
    
//     void **slot = (void **)(static_cast<char*>(obj_ptr)+offset);
    
//     if (ClassPointers.count(nested_type)>0)
//       set_train_worklist(scope_struct, *slot, nested_type);
    
//     if (train_mode_fn.count(nested_type)&&check_initialized_field((char*)obj_ptr + offset))
//       train_mode_fn[nested_type](*slot);

//   }
// }

// extern "C" float train_mode(Scope_Struct *scope_struct, void *obj_ptr)
// {
//   std::string data_type = get_pool_obj_type(scope_struct, obj_ptr);

//   for (int i=0; i<ClassPointers[data_type].size(); ++i) {
//     std::string obj_type = ClassPointersType[data_type][i];
//     int offset = ClassPointers[data_type][i];

//     void **slot = (void **)(static_cast<char*>(obj_ptr)+offset);
    
//     if (ClassPointers.count(obj_type)>0)
//       set_train_worklist(scope_struct, *slot, obj_type);

//     if (train_mode_fn.count(obj_type)&&check_initialized_field((char*)obj_ptr + offset))
//       train_mode_fn[obj_type](*slot);
//   }
//   return 0;
// }




// void set_infer_worklist(Scope_Struct *scope_struct, void *obj_ptr, std::string obj_type) {
//   for (int i=0; i<ClassPointers[obj_type].size(); ++i) {
//     std::string nested_type = ClassPointersType[obj_type][i];
//     int offset = ClassPointers[obj_type][i];
    
//     void **slot = (void **)(static_cast<char*>(obj_ptr)+offset);
    
//     if (ClassPointers.count(nested_type)>0)
//       set_infer_worklist(scope_struct, *slot, nested_type);

//     if (infer_mode_fn.count(nested_type)&&check_initialized_field((char*)obj_ptr + offset))
//       infer_mode_fn[nested_type](*slot);
//   }
// }

// extern "C" float infer_mode(Scope_Struct *scope_struct, void *obj_ptr)
// {
//   std::string data_type = get_pool_obj_type(scope_struct, obj_ptr);
 
//   for (int i=0; i<ClassPointers[data_type].size(); ++i) {
//     std::string obj_type = ClassPointersType[data_type][i];
//     int offset = ClassPointers[data_type][i];

//     void **slot = (void **)(static_cast<char*>(obj_ptr)+offset);
    
//     if (ClassPointers.count(obj_type)>0)
//       set_infer_worklist(scope_struct, *slot, obj_type);

//     if (infer_mode_fn.count(obj_type)&&check_initialized_field((char*)obj_ptr + offset))
//       infer_mode_fn[obj_type](*slot);
//   }
  
//   return 0;
// }
