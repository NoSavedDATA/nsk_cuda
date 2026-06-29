#pragma once

#include "../../../../src/nsk_cpp.h"

struct img_load_ret {
    void *float_cpu;
    DT_array *dims;
    img_load_ret(void *, DT_array*);
};
