obj/mma/general.o: src/mma/general.cu src/mma/../common/cu_commons.h \
  src/mma/../cuda_threads/include.h src/mma/../cuda_threads/threads.h \
  src/mma/../cuda_kernels/handles.h src/mma/../tensor/include.h \
  src/mma/../tensor/../../../../src/nsk_cpp.h \
  src/mma/../tensor/../../../../src/char_pool/include.h \
  src/mma/../tensor/../../../../src/char_pool/char_pool.h \
  src/mma/../tensor/../../../../src/char_pool/../common/extension_functions.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/include.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/barrier.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/channels.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/list.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/../mangler/scope_struct.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/include.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/clean_up.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/mark_sweep.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/codegen_notes.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/nsk_vector.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/lock.h \
  src/mma/../tensor/../../../../src/char_pool/../threads/utils.h \
  src/mma/../tensor/../../../../src/clean_up/include.h \
  src/mma/../tensor/../../../../src/clean_up/clean_up.h \
  src/mma/../tensor/../../../../src/codegen/random.h \
  src/mma/../tensor/../../../../src/common/extension_functions.h \
  src/mma/../tensor/../../../../src/compiler_frontend/logging_execution.h \
  src/mma/../tensor/../../../../src/compiler_frontend/logging_v.h \
  src/mma/../tensor/../../../../src/compiler_frontend/global_vars.h \
  src/mma/../tensor/../../../../src/data_types/codegen_notes.h \
  src/mma/../tensor/../../../../src/data_types/float_vec.h \
  src/mma/../tensor/../../../../src/data_types/../mangler/scope_struct.h \
  src/mma/../tensor/../../../../src/data_types/nsk_vector.h \
  src/mma/../tensor/../../../../src/math/include.h \
  src/mma/../tensor/../../../../src/math/functions.h \
  src/mma/../tensor/../../../../src/mangler/include.h \
  src/mma/../tensor/../../../../src/mangler/scope_struct.h \
  src/mma/../tensor/../../../../src/mark_sweep/include.h \
  src/mma/../tensor/../../../../src/notators/include.h \
  src/mma/../tensor/../../../../src/notators/notators.h \
  src/mma/../tensor/../../../../src/os/include.h \
  src/mma/../tensor/../../../../src/os/dir/include.h \
  src/mma/../tensor/../../../../src/os/dir/dir.h \
  src/mma/../tensor/../../../../src/pool/include.h \
  src/mma/../tensor/../../../../src/pool/../mangler/scope_struct.h \
  src/mma/../tensor/../../../../src/pool/../mark_sweep/include.h \
  src/mma/../tensor/../../../../src/pool/pool.h \
  src/mma/../tensor/../../../../src/threads/include.h \
  src/mma/../tensor/print.h src/mma/../tensor/tensor_struct.h \
  src/mma/../tensor/../cuda_threads/include.h \
  src/mma/../tensor/../nsk_cuda/minimal_tensor.h \
  src/mma/../tensor/../nsk_cuda/../../../../src/nsk_cpp.h \
  src/mma/../tensor/../nsk_cuda/pool/include.h \
  src/mma/../tensor/../nsk_cuda/pool/pool_i8.h \
  src/mma/../tensor/../nsk_cuda/pool/../../../../../src/nsk_cpp.h \
  src/mma/../tensor/../nsk_cuda/pool/pool_i32.h \
  src/mma/../tensor/../nsk_cuda/pool/pool.h \
  src/mma/../tensor/tensor_dim_functions.h src/mma/utils.h \
  src/mma/util.h src/mma/util_ptx.cu src/mma/../nsk_cuda/include.h \
  src/mma/../nsk_cuda/fragments/include.h \
  src/mma/../nsk_cuda/fragments/frag_to_smem.h \
  src/mma/../nsk_cuda/fragments/inlines.h \
  src/mma/../nsk_cuda/fragments/../smem/include.h \
  src/mma/../nsk_cuda/fragments/../smem/inlines.cu \
  src/mma/../nsk_cuda/fragments/../smem/gmem_to_smem.h \
  src/mma/../nsk_cuda/fragments/smem_to_frag.cuh \
  src/mma/../nsk_cuda/smem/include.h \
  src/mma/../nsk_cuda/structs/include.h \
  src/mma/../nsk_cuda/structs/smem_loads/include.h \
  src/mma/../nsk_cuda/structs/smem_loads/indexed.h \
  src/mma/../nsk_cuda/structs/smem_loads/../../smem/include.h \
  src/mma/../nsk_cuda/structs/smem_loads/../smem_cpasync_loader.h \
  src/mma/../nsk_cuda/structs/smem_loads/../wmma_indexes.h \
  src/mma/../nsk_cuda/structs/smem_loads/../fp16_wmma_frags.h \
  src/mma/../nsk_cuda/structs/smem_loads/../i8_wmma_frags.h \
  src/mma/../nsk_cuda/structs/smem_loads/standard.h \
  src/mma/../nsk_cuda/structs/smem_loads/transposed.h \
  src/mma/../nsk_cuda/structs/smem_loads/transposed_index.h \
  src/mma/../nsk_cuda/structs/smem_stores/include.h \
  src/mma/../nsk_cuda/structs/smem_stores/i8mma.h \
  src/mma/../nsk_cuda/structs/fp16_wmma_frags.h \
  src/mma/../nsk_cuda/structs/i8_wmma_frags.h \
  src/mma/../nsk_cuda/structs/smem_cpasync_loader.h \
  src/mma/../nsk_cuda/structs/smem_loader.h \
  src/mma/../nsk_cuda/structs/wmma_indexes.h \
  src/mma/../nsk_cuda/quantize/include.h \
  src/mma/../nsk_cuda/quantize/call.h \
  src/mma/../nsk_cuda/quantize/../minimal_tensor.h \
  src/mma/../nsk_cuda/quantize/quantize_f32_i4.h \
  src/mma/../nsk_cuda/quantize/quantize_f32_i8.h \
  src/mma/../nsk_cuda/quantize/quantize.cuh \
  src/mma/../nsk_cuda/pool/include.h \
  src/mma/../nsk_cuda/transpose/include.h \
  src/mma/../nsk_cuda/transpose/call.h \
  src/mma/../nsk_cuda/transpose/transpose_kernel.h \
  src/mma/../nsk_cuda/warp_ops/include.h \
  src/mma/../nsk_cuda/warp_ops/max.h src/mma/../nsk_cuda/wmma/include.h \
  src/mma/../nsk_cuda/wmma/i4/include.h \
  src/mma/../nsk_cuda/wmma/i4/i4_16x16x16_mma.h \
  src/mma/../nsk_cuda/wmma/i4/../../structs/i8_wmma_frags.h \
  src/mma/../nsk_cuda/wmma/i4/../../math/divs.h \
  src/mma/../nsk_cuda/wmma/i4/ptx.h \
  src/mma/../nsk_cuda/wmma/i8/include.h \
  src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_dx.h \
  src/mma/../nsk_cuda/wmma/i8/../../structs/i8_wmma_frags.h \
  src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_warp_tile.h \
  src/mma/../nsk_cuda/wmma/i8/ptx.h \
  src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_dw.h \
  src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_mma.h \
  src/mma/../nsk_cuda/wmma/i8/../../math/divs.h \
  src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_warp_tile_mma.h \
  src/mma/../nsk_cuda/wmma/i8/i8_16x16x16.h \
  src/mma/../nsk_cuda/wmma/indexed/include.h \
  src/mma/../nsk_cuda/wmma/indexed/fp16_16x16x16_dw_L_index.h \
  src/mma/../nsk_cuda/wmma/indexed/../../structs/fp16_wmma_frags.h \
  src/mma/../nsk_cuda/wmma/indexed/../fp16_16x16x16_warp_tile.h \
  src/mma/../nsk_cuda/wmma/indexed/../ptx.h \
  src/mma/../nsk_cuda/wmma/indexed/fp16_16x16x16_L_index.h \
  src/mma/../nsk_cuda/wmma/fp16_16x16x16_dx.h \
  src/mma/../nsk_cuda/wmma/../structs/fp16_wmma_frags.h \
  src/mma/../nsk_cuda/wmma/fp16_16x16x16_warp_tile.h \
  src/mma/../nsk_cuda/wmma/fp16_16x16x16_dw.h \
  src/mma/../nsk_cuda/wmma/fp16_16x16x16.h \
  src/mma/../nsk_cuda/wmma/ptx.h src/mma/../nsk_cuda/minimal_tensor.h
src/mma/../common/cu_commons.h:
src/mma/../cuda_threads/include.h:
src/mma/../cuda_threads/threads.h:
src/mma/../cuda_kernels/handles.h:
src/mma/../tensor/include.h:
src/mma/../tensor/../../../../src/nsk_cpp.h:
src/mma/../tensor/../../../../src/char_pool/include.h:
src/mma/../tensor/../../../../src/char_pool/char_pool.h:
src/mma/../tensor/../../../../src/char_pool/../common/extension_functions.h:
src/mma/../tensor/../../../../src/char_pool/../threads/include.h:
src/mma/../tensor/../../../../src/char_pool/../threads/barrier.h:
src/mma/../tensor/../../../../src/char_pool/../threads/channels.h:
src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/list.h:
src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/../mangler/scope_struct.h:
src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/include.h:
src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/clean_up.h:
src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/../mangler/../mark_sweep/mark_sweep.h:
src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/codegen_notes.h:
src/mma/../tensor/../../../../src/char_pool/../threads/../data_types/nsk_vector.h:
src/mma/../tensor/../../../../src/char_pool/../threads/lock.h:
src/mma/../tensor/../../../../src/char_pool/../threads/utils.h:
src/mma/../tensor/../../../../src/clean_up/include.h:
src/mma/../tensor/../../../../src/clean_up/clean_up.h:
src/mma/../tensor/../../../../src/codegen/random.h:
src/mma/../tensor/../../../../src/common/extension_functions.h:
src/mma/../tensor/../../../../src/compiler_frontend/logging_execution.h:
src/mma/../tensor/../../../../src/compiler_frontend/logging_v.h:
src/mma/../tensor/../../../../src/compiler_frontend/global_vars.h:
src/mma/../tensor/../../../../src/data_types/codegen_notes.h:
src/mma/../tensor/../../../../src/data_types/float_vec.h:
src/mma/../tensor/../../../../src/data_types/../mangler/scope_struct.h:
src/mma/../tensor/../../../../src/data_types/nsk_vector.h:
src/mma/../tensor/../../../../src/math/include.h:
src/mma/../tensor/../../../../src/math/functions.h:
src/mma/../tensor/../../../../src/mangler/include.h:
src/mma/../tensor/../../../../src/mangler/scope_struct.h:
src/mma/../tensor/../../../../src/mark_sweep/include.h:
src/mma/../tensor/../../../../src/notators/include.h:
src/mma/../tensor/../../../../src/notators/notators.h:
src/mma/../tensor/../../../../src/os/include.h:
src/mma/../tensor/../../../../src/os/dir/include.h:
src/mma/../tensor/../../../../src/os/dir/dir.h:
src/mma/../tensor/../../../../src/pool/include.h:
src/mma/../tensor/../../../../src/pool/../mangler/scope_struct.h:
src/mma/../tensor/../../../../src/pool/../mark_sweep/include.h:
src/mma/../tensor/../../../../src/pool/pool.h:
src/mma/../tensor/../../../../src/threads/include.h:
src/mma/../tensor/print.h:
src/mma/../tensor/tensor_struct.h:
src/mma/../tensor/../cuda_threads/include.h:
src/mma/../tensor/../nsk_cuda/minimal_tensor.h:
src/mma/../tensor/../nsk_cuda/../../../../src/nsk_cpp.h:
src/mma/../tensor/../nsk_cuda/pool/include.h:
src/mma/../tensor/../nsk_cuda/pool/pool_i8.h:
src/mma/../tensor/../nsk_cuda/pool/../../../../../src/nsk_cpp.h:
src/mma/../tensor/../nsk_cuda/pool/pool_i32.h:
src/mma/../tensor/../nsk_cuda/pool/pool.h:
src/mma/../tensor/tensor_dim_functions.h:
src/mma/utils.h:
src/mma/util.h:
src/mma/util_ptx.cu:
src/mma/../nsk_cuda/include.h:
src/mma/../nsk_cuda/fragments/include.h:
src/mma/../nsk_cuda/fragments/frag_to_smem.h:
src/mma/../nsk_cuda/fragments/inlines.h:
src/mma/../nsk_cuda/fragments/../smem/include.h:
src/mma/../nsk_cuda/fragments/../smem/inlines.cu:
src/mma/../nsk_cuda/fragments/../smem/gmem_to_smem.h:
src/mma/../nsk_cuda/fragments/smem_to_frag.cuh:
src/mma/../nsk_cuda/smem/include.h:
src/mma/../nsk_cuda/structs/include.h:
src/mma/../nsk_cuda/structs/smem_loads/include.h:
src/mma/../nsk_cuda/structs/smem_loads/indexed.h:
src/mma/../nsk_cuda/structs/smem_loads/../../smem/include.h:
src/mma/../nsk_cuda/structs/smem_loads/../smem_cpasync_loader.h:
src/mma/../nsk_cuda/structs/smem_loads/../wmma_indexes.h:
src/mma/../nsk_cuda/structs/smem_loads/../fp16_wmma_frags.h:
src/mma/../nsk_cuda/structs/smem_loads/../i8_wmma_frags.h:
src/mma/../nsk_cuda/structs/smem_loads/standard.h:
src/mma/../nsk_cuda/structs/smem_loads/transposed.h:
src/mma/../nsk_cuda/structs/smem_loads/transposed_index.h:
src/mma/../nsk_cuda/structs/smem_stores/include.h:
src/mma/../nsk_cuda/structs/smem_stores/i8mma.h:
src/mma/../nsk_cuda/structs/fp16_wmma_frags.h:
src/mma/../nsk_cuda/structs/i8_wmma_frags.h:
src/mma/../nsk_cuda/structs/smem_cpasync_loader.h:
src/mma/../nsk_cuda/structs/smem_loader.h:
src/mma/../nsk_cuda/structs/wmma_indexes.h:
src/mma/../nsk_cuda/quantize/include.h:
src/mma/../nsk_cuda/quantize/call.h:
src/mma/../nsk_cuda/quantize/../minimal_tensor.h:
src/mma/../nsk_cuda/quantize/quantize_f32_i4.h:
src/mma/../nsk_cuda/quantize/quantize_f32_i8.h:
src/mma/../nsk_cuda/quantize/quantize.cuh:
src/mma/../nsk_cuda/pool/include.h:
src/mma/../nsk_cuda/transpose/include.h:
src/mma/../nsk_cuda/transpose/call.h:
src/mma/../nsk_cuda/transpose/transpose_kernel.h:
src/mma/../nsk_cuda/warp_ops/include.h:
src/mma/../nsk_cuda/warp_ops/max.h:
src/mma/../nsk_cuda/wmma/include.h:
src/mma/../nsk_cuda/wmma/i4/include.h:
src/mma/../nsk_cuda/wmma/i4/i4_16x16x16_mma.h:
src/mma/../nsk_cuda/wmma/i4/../../structs/i8_wmma_frags.h:
src/mma/../nsk_cuda/wmma/i4/../../math/divs.h:
src/mma/../nsk_cuda/wmma/i4/ptx.h:
src/mma/../nsk_cuda/wmma/i8/include.h:
src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_dx.h:
src/mma/../nsk_cuda/wmma/i8/../../structs/i8_wmma_frags.h:
src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_warp_tile.h:
src/mma/../nsk_cuda/wmma/i8/ptx.h:
src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_dw.h:
src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_mma.h:
src/mma/../nsk_cuda/wmma/i8/../../math/divs.h:
src/mma/../nsk_cuda/wmma/i8/i8_16x16x16_warp_tile_mma.h:
src/mma/../nsk_cuda/wmma/i8/i8_16x16x16.h:
src/mma/../nsk_cuda/wmma/indexed/include.h:
src/mma/../nsk_cuda/wmma/indexed/fp16_16x16x16_dw_L_index.h:
src/mma/../nsk_cuda/wmma/indexed/../../structs/fp16_wmma_frags.h:
src/mma/../nsk_cuda/wmma/indexed/../fp16_16x16x16_warp_tile.h:
src/mma/../nsk_cuda/wmma/indexed/../ptx.h:
src/mma/../nsk_cuda/wmma/indexed/fp16_16x16x16_L_index.h:
src/mma/../nsk_cuda/wmma/fp16_16x16x16_dx.h:
src/mma/../nsk_cuda/wmma/../structs/fp16_wmma_frags.h:
src/mma/../nsk_cuda/wmma/fp16_16x16x16_warp_tile.h:
src/mma/../nsk_cuda/wmma/fp16_16x16x16_dw.h:
src/mma/../nsk_cuda/wmma/fp16_16x16x16.h:
src/mma/../nsk_cuda/wmma/ptx.h:
src/mma/../nsk_cuda/minimal_tensor.h:
