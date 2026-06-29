#include "../../src/nsk_cpp_llvm.h"
#include "../../src/std/codegen.h"


extern "C" Value *cumalloc(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_pp"])});
    call("cudaMalloc", {ret, Builder->CreateIntCast(ArgsV[0],int64Ty,true)});
    return ret;
}

extern "C" Value *cumalloc_host(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_cpu"])});
    call("cudaMallocHost", {ret, Builder->CreateIntCast(ArgsV[0], int64Ty, true)});
    return ret;
}

extern "C" Value *device_to_host(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_cpu"])});
    call("cudaMallocHost", {ret, Builder->CreateIntCast(ArgsV[1], int64Ty, true)});

    Value *dest = Builder->CreateLoad(int8PtrTy, ret);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, Builder->CreateIntCast(ArgsV[1], int64Ty, true), const_int(2)});
    return ret;
}




// --------- float32 --------- //

extern "C" Value *float_pp_cpu(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *size = Builder->CreateMul(ArgsV[1], const_int(4));
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_cpu"])});
    call("cudaMallocHost", {ret, Builder->CreateIntCast(size, intTy, true)});

    Value *dest = Builder->CreateLoad(int8PtrTy, ret);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, Builder->CreateIntCast(size, intTy, true), const_int(2)});
    return ret;
}

extern "C" Value *host_to_device(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *dest = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[1]);
    call("cudaMemcpy", {dest, src, Builder->CreateIntCast(ArgsV[2], int64Ty, true), const_int(1)});
    return const_int(0);
}

extern "C" Value *float_cpu_cuda(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *size = Builder->CreateMul(ArgsV[1], const_int(4));
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_pp"])});
    call("cudaMalloc", {ret, Builder->CreateIntCast(size, int64Ty, true)});
    
    Value *dest = Builder->CreateLoad(int8PtrTy, ret);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, Builder->CreateIntCast(size,int64Ty,true), const_int(1)});
    return ret;
}

extern "C" Value *float_cpu_cupool(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *size = Builder->CreateMul(ArgsV[1], const_int(4));
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_pp"])});
    
    Value *dest = callret("pool_alloc_float_pp", {scope_struct, size});
    Builder->CreateStore(dest, ret);

    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, Builder->CreateIntCast(size,int64Ty,true), const_int(1)});
    return ret;
}






// --------- bf16 --------- //
extern "C" Value *bf16_pp_cpu(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *size = Builder->CreateMul(ArgsV[1], const_int(2));
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["bf16_cpu"])});
    call("cudaMallocHost", {ret, Builder->CreateIntCast(size, int64Ty, true)});

    Value *dest = Builder->CreateLoad(int8PtrTy, ret);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, Builder->CreateIntCast(size, int64Ty, true), const_int(2)});
    return ret;
}

extern "C" Value *bf16_cpu_cuda(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *size = Builder->CreateMul(ArgsV[1], const_int(2));
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["bf16_pp"])});
    call("cudaMalloc", {ret, Builder->CreateIntCast(size, int64Ty, true)});
    
    Value *dest = Builder->CreateLoad(int8PtrTy, ret);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, Builder->CreateIntCast(size, int64Ty, true), const_int(1)});
    return ret;
}


extern "C" Value *bf16_cpu_cupool(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *size = Builder->CreateMul(ArgsV[1], const_int(2));
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["bf16_pp"])});
    
    Value *dest = callret("pool_alloc_bf16_pp", {scope_struct, size});
    Builder->CreateStore(dest, ret);

    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, Builder->CreateIntCast(size, int64Ty, true), const_int(1)});
    return ret;
}
