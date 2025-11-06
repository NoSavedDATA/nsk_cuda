

struct Smem_Loader {

  int smem_offset=0;

  template <typename T>
  __device__ T* smem_malloc(T* smem, int size) {
    int alignment = alignof(T);
    // Convert alignment from bytes to number of T-sized elements
    int align_elements = (alignment + sizeof(T) - 1) / sizeof(T);
    smem_offset = (smem_offset + align_elements - 1) & ~(align_elements - 1);

    T* ret_ptr = smem + smem_offset;
    smem_offset += size;
    return ret_ptr;
  }
};