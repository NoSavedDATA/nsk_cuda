#include <iostream>


#include "../common/cu_commons.h"
#include "../../../../src/nsk_cpp.h"

// #include "../../common/cu_commons.h"

#include "img.h"
#include "stb_lib.h"

img_load_ret::img_load_ret(void *float_cpu, DT_array *dims)
        : float_cpu(float_cpu), dims(dims) {}


extern "C" img_load_ret load_image(Scope_Struct *scope_struct, char *img_name) {
    // std::cout << "Image: " << img_name <<  "\n";

    int width, height, channels;
    unsigned char* image_data = stbi_load(img_name, &width, &height, &channels, 0);
    // std::cout << "W " << width << ", H " << height  << ", C " << channels << "\n";

    if (image_data) {
        DT_array *dims = newT<DT_array>(scope_struct, "array");
        dims->New(scope_struct, 3, 4, scope_struct->thread_id, 2);
        __atomic_store_n(&dims->virtual_size, 3, __ATOMIC_RELEASE);
        int *data = (int*)dims->data;
        data[0] = channels; 
        data[1] = width;
        data[2] = height; 

        void **ptr = (void**)allocate_pool(scope_struct, 8, data_name_to_type()["float_cpu"]);

        float *image_data_float;
        cudaMallocHost(&image_data_float, width*height*channels*4);
        *ptr = image_data_float;

        // Loop through each pixel and convert to float between 0.0 and 1.0
        for (int y = 0; y < height; ++y) {
          for (int x = 0; x < width; ++x) {
            for (int c = 0; c < channels; ++c) {
              // Assuming unsigned char has 8 bits, scale by 1/255.0 to get a float value between 0.0 and 1.0
              image_data_float[c * (height * width) + y * width + x] = (float)image_data[(y * width + x) * channels + c] / 255.0f;
            }
          }
        }
        stbi_image_free(image_data);

        return img_load_ret((void*)ptr, dims);
    } else {
        std::string img_n = img_name;
        std::string _error = "Failed to open image: " + img_n + ".\n\n";
        LogErrorC(scope_struct->code_line, _error);
    }

    return img_load_ret(nullptr, nullptr);
}


extern "C" int float_cpu_load_img(Scope_Struct *scope_struct, void *float_cpu, char *img_name) {
    // std::cout << "Image: " << img_name <<  "\n";

    int width, height, channels;
    unsigned char* image_data = stbi_load(img_name, &width, &height, &channels, 0);
    // std::cout << "W " << width << ", H " << height  << ", C " << channels << "\n";

    if (image_data) {
        float *image_data_float = *(float**)float_cpu;
        // std::cout << "image_data_float " << image_data_float<< "\n";

        // Loop through each pixel and convert to float between 0.0 and 1.0
        for (int y = 0; y < height; ++y) {
          for (int x = 0; x < width; ++x) {
            for (int c = 0; c < channels; ++c) {
              // Assuming unsigned char has 8 bits, scale by 1/255.0 to get a float value between 0.0 and 1.0
              image_data_float[c * (height * width) + y * width + x] = (float)image_data[(y * width + x) * channels + c] / 255.0f;
            }
          }
        }
        stbi_image_free(image_data);

        return 0;
    } else {
        std::string img_n = img_name;
        std::string _error = "Failed to open image: " + img_n + ".\n\n";
        LogErrorC(scope_struct->code_line, _error);
    }

    return -1;
}
