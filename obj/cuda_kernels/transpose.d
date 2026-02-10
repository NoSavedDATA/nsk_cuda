obj/cuda_kernels/transpose.o: src/cuda_kernels/transpose.cu \
  src/../../../src/nsk_cpp.h src/../../../src/char_pool/include.h \
  src/../../../src/char_pool/char_pool.h \
  src/../../../src/char_pool/../common/extension_functions.h \
  src/../../../src/char_pool/../threads/include.h \
  src/../../../src/char_pool/../threads/barrier.h \
  src/../../../src/char_pool/../threads/channels.h \
  src/../../../src/char_pool/../threads/../data_types/list.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/scope_struct.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/include.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/clean_up.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/mark_sweep.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/include.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/allocation.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/address_protection.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../compiler_frontend/global_vars.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../compiler_frontend/logging_v.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../clean_up/clean_up.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../data_types/list.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../mangler/scope_struct.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../pool/pool.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../pool/../mangler/scope_struct.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../include.h \
  src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/auxiliary_fn.h \
  src/../../../src/char_pool/../threads/../data_types/codegen_notes.h \
  src/../../../src/char_pool/../threads/../data_types/nsk_vector.h \
  src/../../../src/char_pool/../threads/../data_types/int_vec.h \
  src/../../../src/char_pool/../threads/lock.h \
  src/../../../src/char_pool/../threads/utils.h \
  src/../../../src/clean_up/include.h \
  src/../../../src/clean_up/clean_up.h src/../../../src/codegen/random.h \
  src/../../../src/common/extension_functions.h \
  src/../../../src/compiler_frontend/logging_execution.h \
  src/../../../src/compiler_frontend/logging_v.h \
  src/../../../src/compiler_frontend/global_vars.h \
  src/../../../src/data_types/codegen_notes.h \
  src/../../../src/data_types/array.h \
  src/../../../src/data_types/float_vec.h \
  src/../../../src/data_types/../mangler/scope_struct.h \
  src/../../../src/data_types/map.h \
  src/../../../src/data_types/../compiler_frontend/logging_v.h \
  src/../../../src/data_types/nsk_vector.h \
  src/../../../src/math/include.h src/../../../src/math/functions.h \
  src/../../../src/mangler/include.h \
  src/../../../src/mangler/scope_struct.h \
  src/../../../src/mark_sweep/include.h \
  src/../../../src/notators/include.h \
  src/../../../src/notators/notators.h src/../../../src/os/include.h \
  src/../../../src/os/dir/include.h src/../../../src/os/dir/dir.h \
  src/../../../src/pool/include.h \
  src/../../../src/pool/../compiler_frontend/global_vars.h \
  src/../../../src/pool/../compiler_frontend/logging_v.h \
  src/../../../src/pool/../mangler/scope_struct.h \
  src/../../../src/pool/../mark_sweep/include.h \
  src/../../../src/pool/pool.h src/../../../src/threads/include.h \
  src/cuda_kernels/../nsk_cuda/include.h \
  src/cuda_kernels/../nsk_cuda/fragments/include.h \
  src/cuda_kernels/../nsk_cuda/fragments/frag_to_smem.h \
  src/cuda_kernels/../nsk_cuda/fragments/inlines.h \
  src/cuda_kernels/../nsk_cuda/fragments/../smem/include.h \
  src/cuda_kernels/../nsk_cuda/fragments/../smem/inlines.cu \
  src/cuda_kernels/../nsk_cuda/fragments/../smem/gmem_to_smem.h \
  src/cuda_kernels/../nsk_cuda/fragments/smem_to_frag.cuh \
  src/cuda_kernels/../nsk_cuda/smem/include.h \
  src/cuda_kernels/../nsk_cuda/structs/include.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/include.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/indexed.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/../../smem/include.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/../smem_cpasync_loader.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/../wmma_indexes.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/../fp16_wmma_frags.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/../i8_wmma_frags.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/standard.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/transposed.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loads/transposed_index.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_stores/include.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_stores/i8mma.h \
  src/cuda_kernels/../nsk_cuda/structs/fp16_wmma_frags.h \
  src/cuda_kernels/../nsk_cuda/structs/i8_wmma_frags.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_cpasync_loader.h \
  src/cuda_kernels/../nsk_cuda/structs/smem_loader.h \
  src/cuda_kernels/../nsk_cuda/structs/wmma_indexes.h \
  src/cuda_kernels/../nsk_cuda/quantize/include.h \
  src/cuda_kernels/../nsk_cuda/quantize/call.h \
  src/cuda_kernels/../nsk_cuda/quantize/../minimal_tensor.h \
  src/cuda_kernels/../nsk_cuda/quantize/../../../../../src/nsk_cpp.h \
  src/cuda_kernels/../nsk_cuda/quantize/../pool/include.h \
  src/cuda_kernels/../nsk_cuda/quantize/../pool/pool_i8.h \
  src/cuda_kernels/../nsk_cuda/quantize/../pool/../../../../../src/nsk_cpp.h \
  src/cuda_kernels/../nsk_cuda/quantize/../pool/pool_i32.h \
  src/cuda_kernels/../nsk_cuda/quantize/../pool/pool.h \
  src/cuda_kernels/../nsk_cuda/quantize/quantize_f32_i4.h \
  src/cuda_kernels/../nsk_cuda/quantize/quantize_f32_i8.h \
  src/cuda_kernels/../nsk_cuda/quantize/quantize.cuh \
  src/cuda_kernels/../nsk_cuda/pool/include.h \
  src/cuda_kernels/../nsk_cuda/transpose/include.h \
  src/cuda_kernels/../nsk_cuda/transpose/call.h \
  src/cuda_kernels/../nsk_cuda/transpose/transpose_kernel.h \
  src/cuda_kernels/../nsk_cuda/warp_ops/include.h \
  src/cuda_kernels/../nsk_cuda/warp_ops/max.h \
  src/cuda_kernels/../nsk_cuda/wmma/include.h \
  src/cuda_kernels/../nsk_cuda/wmma/i4/include.h \
  src/cuda_kernels/../nsk_cuda/wmma/i4/i4_16x16x16_mma.h \
  src/cuda_kernels/../nsk_cuda/wmma/i4/../../structs/i8_wmma_frags.h \
  src/cuda_kernels/../nsk_cuda/wmma/i4/../../math/divs.h \
  src/cuda_kernels/../nsk_cuda/wmma/i4/ptx.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/include.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_dx.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/../../structs/i8_wmma_frags.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_warp_tile.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/ptx.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_dw.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_mma.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/../../math/divs.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_warp_tile_mma.h \
  src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16.h \
  src/cuda_kernels/../nsk_cuda/wmma/indexed/include.h \
  src/cuda_kernels/../nsk_cuda/wmma/indexed/fp16_16x16x16_dw_L_index.h \
  src/cuda_kernels/../nsk_cuda/wmma/indexed/../../structs/fp16_wmma_frags.h \
  src/cuda_kernels/../nsk_cuda/wmma/indexed/../fp16_16x16x16_warp_tile.h \
  src/cuda_kernels/../nsk_cuda/wmma/indexed/../ptx.h \
  src/cuda_kernels/../nsk_cuda/wmma/indexed/fp16_16x16x16_L_index.h \
  src/cuda_kernels/../nsk_cuda/wmma/fp16_16x16x16_dx.h \
  src/cuda_kernels/../nsk_cuda/wmma/../structs/fp16_wmma_frags.h \
  src/cuda_kernels/../nsk_cuda/wmma/fp16_16x16x16_warp_tile.h \
  src/cuda_kernels/../nsk_cuda/wmma/fp16_16x16x16_dw.h \
  src/cuda_kernels/../nsk_cuda/wmma/fp16_16x16x16.h \
  src/cuda_kernels/../nsk_cuda/wmma/ptx.h \
  src/cuda_kernels/../nsk_cuda/minimal_tensor.h \
  src/cuda_kernels/../tensor/include.h \
  src/cuda_kernels/../tensor/../../../../src/nsk_cpp.h \
  src/cuda_kernels/../tensor/print.h \
  src/cuda_kernels/../tensor/tensor_struct.h \
  src/cuda_kernels/../tensor/../cuda_threads/include.h \
  src/cuda_kernels/../tensor/../cuda_threads/threads.h \
  src/cuda_kernels/../tensor/../nsk_cuda/minimal_tensor.h \
  src/cuda_kernels/../tensor/tensor_dim_functions.h
src/../../../src/nsk_cpp.h:
src/../../../src/char_pool/include.h:
src/../../../src/char_pool/char_pool.h:
src/../../../src/char_pool/../common/extension_functions.h:
src/../../../src/char_pool/../threads/include.h:
src/../../../src/char_pool/../threads/barrier.h:
src/../../../src/char_pool/../threads/channels.h:
src/../../../src/char_pool/../threads/../data_types/list.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/scope_struct.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/include.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/clean_up.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/mark_sweep.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/include.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/allocation.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/address_protection.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../compiler_frontend/global_vars.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../compiler_frontend/logging_v.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../clean_up/clean_up.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../data_types/list.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../mangler/scope_struct.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../pool/pool.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../../pool/../mangler/scope_struct.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/../include.h:
src/../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/modules/auxiliary_fn.h:
src/../../../src/char_pool/../threads/../data_types/codegen_notes.h:
src/../../../src/char_pool/../threads/../data_types/nsk_vector.h:
src/../../../src/char_pool/../threads/../data_types/int_vec.h:
src/../../../src/char_pool/../threads/lock.h:
src/../../../src/char_pool/../threads/utils.h:
src/../../../src/clean_up/include.h:
src/../../../src/clean_up/clean_up.h:
src/../../../src/codegen/random.h:
src/../../../src/common/extension_functions.h:
src/../../../src/compiler_frontend/logging_execution.h:
src/../../../src/compiler_frontend/logging_v.h:
src/../../../src/compiler_frontend/global_vars.h:
src/../../../src/data_types/codegen_notes.h:
src/../../../src/data_types/array.h:
src/../../../src/data_types/float_vec.h:
src/../../../src/data_types/../mangler/scope_struct.h:
src/../../../src/data_types/map.h:
src/../../../src/data_types/../compiler_frontend/logging_v.h:
src/../../../src/data_types/nsk_vector.h:
src/../../../src/math/include.h:
src/../../../src/math/functions.h:
src/../../../src/mangler/include.h:
src/../../../src/mangler/scope_struct.h:
src/../../../src/mark_sweep/include.h:
src/../../../src/notators/include.h:
src/../../../src/notators/notators.h:
src/../../../src/os/include.h:
src/../../../src/os/dir/include.h:
src/../../../src/os/dir/dir.h:
src/../../../src/pool/include.h:
src/../../../src/pool/../compiler_frontend/global_vars.h:
src/../../../src/pool/../compiler_frontend/logging_v.h:
src/../../../src/pool/../mangler/scope_struct.h:
src/../../../src/pool/../mark_sweep/include.h:
src/../../../src/pool/pool.h:
src/../../../src/threads/include.h:
src/cuda_kernels/../nsk_cuda/include.h:
src/cuda_kernels/../nsk_cuda/fragments/include.h:
src/cuda_kernels/../nsk_cuda/fragments/frag_to_smem.h:
src/cuda_kernels/../nsk_cuda/fragments/inlines.h:
src/cuda_kernels/../nsk_cuda/fragments/../smem/include.h:
src/cuda_kernels/../nsk_cuda/fragments/../smem/inlines.cu:
src/cuda_kernels/../nsk_cuda/fragments/../smem/gmem_to_smem.h:
src/cuda_kernels/../nsk_cuda/fragments/smem_to_frag.cuh:
src/cuda_kernels/../nsk_cuda/smem/include.h:
src/cuda_kernels/../nsk_cuda/structs/include.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/include.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/indexed.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/../../smem/include.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/../smem_cpasync_loader.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/../wmma_indexes.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/../fp16_wmma_frags.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/../i8_wmma_frags.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/standard.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/transposed.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loads/transposed_index.h:
src/cuda_kernels/../nsk_cuda/structs/smem_stores/include.h:
src/cuda_kernels/../nsk_cuda/structs/smem_stores/i8mma.h:
src/cuda_kernels/../nsk_cuda/structs/fp16_wmma_frags.h:
src/cuda_kernels/../nsk_cuda/structs/i8_wmma_frags.h:
src/cuda_kernels/../nsk_cuda/structs/smem_cpasync_loader.h:
src/cuda_kernels/../nsk_cuda/structs/smem_loader.h:
src/cuda_kernels/../nsk_cuda/structs/wmma_indexes.h:
src/cuda_kernels/../nsk_cuda/quantize/include.h:
src/cuda_kernels/../nsk_cuda/quantize/call.h:
src/cuda_kernels/../nsk_cuda/quantize/../minimal_tensor.h:
src/cuda_kernels/../nsk_cuda/quantize/../../../../../src/nsk_cpp.h:
src/cuda_kernels/../nsk_cuda/quantize/../pool/include.h:
src/cuda_kernels/../nsk_cuda/quantize/../pool/pool_i8.h:
src/cuda_kernels/../nsk_cuda/quantize/../pool/../../../../../src/nsk_cpp.h:
src/cuda_kernels/../nsk_cuda/quantize/../pool/pool_i32.h:
src/cuda_kernels/../nsk_cuda/quantize/../pool/pool.h:
src/cuda_kernels/../nsk_cuda/quantize/quantize_f32_i4.h:
src/cuda_kernels/../nsk_cuda/quantize/quantize_f32_i8.h:
src/cuda_kernels/../nsk_cuda/quantize/quantize.cuh:
src/cuda_kernels/../nsk_cuda/pool/include.h:
src/cuda_kernels/../nsk_cuda/transpose/include.h:
src/cuda_kernels/../nsk_cuda/transpose/call.h:
src/cuda_kernels/../nsk_cuda/transpose/transpose_kernel.h:
src/cuda_kernels/../nsk_cuda/warp_ops/include.h:
src/cuda_kernels/../nsk_cuda/warp_ops/max.h:
src/cuda_kernels/../nsk_cuda/wmma/include.h:
src/cuda_kernels/../nsk_cuda/wmma/i4/include.h:
src/cuda_kernels/../nsk_cuda/wmma/i4/i4_16x16x16_mma.h:
src/cuda_kernels/../nsk_cuda/wmma/i4/../../structs/i8_wmma_frags.h:
src/cuda_kernels/../nsk_cuda/wmma/i4/../../math/divs.h:
src/cuda_kernels/../nsk_cuda/wmma/i4/ptx.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/include.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_dx.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/../../structs/i8_wmma_frags.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_warp_tile.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/ptx.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_dw.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_mma.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/../../math/divs.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16_warp_tile_mma.h:
src/cuda_kernels/../nsk_cuda/wmma/i8/i8_16x16x16.h:
src/cuda_kernels/../nsk_cuda/wmma/indexed/include.h:
src/cuda_kernels/../nsk_cuda/wmma/indexed/fp16_16x16x16_dw_L_index.h:
src/cuda_kernels/../nsk_cuda/wmma/indexed/../../structs/fp16_wmma_frags.h:
src/cuda_kernels/../nsk_cuda/wmma/indexed/../fp16_16x16x16_warp_tile.h:
src/cuda_kernels/../nsk_cuda/wmma/indexed/../ptx.h:
src/cuda_kernels/../nsk_cuda/wmma/indexed/fp16_16x16x16_L_index.h:
src/cuda_kernels/../nsk_cuda/wmma/fp16_16x16x16_dx.h:
src/cuda_kernels/../nsk_cuda/wmma/../structs/fp16_wmma_frags.h:
src/cuda_kernels/../nsk_cuda/wmma/fp16_16x16x16_warp_tile.h:
src/cuda_kernels/../nsk_cuda/wmma/fp16_16x16x16_dw.h:
src/cuda_kernels/../nsk_cuda/wmma/fp16_16x16x16.h:
src/cuda_kernels/../nsk_cuda/wmma/ptx.h:
src/cuda_kernels/../nsk_cuda/minimal_tensor.h:
src/cuda_kernels/../tensor/include.h:
src/cuda_kernels/../tensor/../../../../src/nsk_cpp.h:
src/cuda_kernels/../tensor/print.h:
src/cuda_kernels/../tensor/tensor_struct.h:
src/cuda_kernels/../tensor/../cuda_threads/include.h:
src/cuda_kernels/../tensor/../cuda_threads/threads.h:
src/cuda_kernels/../tensor/../nsk_cuda/minimal_tensor.h:
src/cuda_kernels/../tensor/tensor_dim_functions.h:
