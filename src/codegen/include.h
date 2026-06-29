#pragma once

#include <functional>
#include <string>
#include <unordered_map>

#include "codegen.h"
#include "ops.h"

extern std::map<std::string, std::function<void(void *)>> infer_mode_fn;
extern std::map<std::string, std::function<void(void *)>> train_mode_fn;
