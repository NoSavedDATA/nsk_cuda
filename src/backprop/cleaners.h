#pragma once

#include <string>
#include <map>
#include <vector>

#include "include.h"

// Cleaners
extern std::map<std::string, float *> var_to_grad;
extern std::vector<std::tuple<int, float *, std::string>> backprop_tensors_to_pool;
extern std::vector<float *> tensors_sent_to_pool;
extern std::vector<DT_tensor *> backprop_Tensors_to_free;
extern std::vector<DT_tensor *> backprop_Tensors_to_save;
extern std::map<std::string, std::vector<std::tuple<int, float*,std::string>>> forward_tensors_to_pool;
extern std::map<std::string, std::vector<float*>> forward_tensors_sent_to_pool;
extern std::map<std::string, std::vector<DT_tensor*>> forward_Tensors_to_free;
extern std::map<std::string, std::map<std::string, float*>> scope_tensors; // records last version of a tensor //todo: is this one actually used?
extern std::map<int, std::map<std::string, std::vector<std::tuple<int, float*,std::string>>>> threaded_tensors_to_pool;
extern std::map<int, std::map<std::string, std::vector<float*>>> threaded_tensors_sent_to_pool;
extern std::map<int, std::map<std::string, std::vector<DT_tensor*>>> threaded_Tensors_to_free;
extern std::map<int, std::map<std::string, std::vector<float*>>> threaded_tensors_to_save;
extern std::map<int, std::map<std::string, std::vector<DT_tensor*>>> threaded_Tensors_to_save;

using backward_tuple = std::tuple<int, int, int, int, int, float *, float *, float *, std::string, std::string, std::string>;





void to_free_tensor(DT_tensor *tensor_ptr);
void to_pool(int dims_prod, float *tensor_ptr, std::string from);
void save_from_pool(DT_tensor *tensor_ptr);


void CleanScopeTensors(std::string scope);
void CleanScopeTensors(std::string scope);
void CleanTree_Backprop(DT_tensor *back_node);

