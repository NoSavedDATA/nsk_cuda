#pragma once

#include <functional>
#include <string>
#include <unordered_map>

#include "../tensor/tensor_struct.h"

extern std::map<std::string, std::function<void(void *)>> infer_mode_fn;
extern std::map<std::string, std::function<void(void *)>> train_mode_fn;