#include "../../src/nsk_cpp_llvm.h"
#include "../../src/std/codegen.h"


extern "C" Value *cumalloc(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_pp"])});
    call("cudaMalloc", {ret, ArgsV[0]});
    return ret;
}

extern "C" Value *cumalloc_host(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_cpu"])});
    call("cudaMallocHost", {ret, ArgsV[0]});
    return ret;
}

extern "C" Value *device_to_host(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_cpu"])});
    call("cudaMallocHost", {ret, ArgsV[1]});

    Value *dest = Builder->CreateLoad(int8PtrTy, ret);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, ArgsV[1], const_int(2)});
    return ret;
}

extern "C" Value *float_pp_cpu(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *size = Builder->CreateMul(ArgsV[1], const_int(4));
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_cpu"])});
    call("cudaMallocHost", {ret, size});

    Value *dest = Builder->CreateLoad(int8PtrTy, ret);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    call("cudaMemcpy", {dest, src, size, const_int(2)});
    return ret;
}

extern "C" Value *host_to_device(Parser_Struct parser_struct, Function *TheFunction,
                 std::string Callee, Data_Tree data_type, std::vector<Data_Tree> &args_type,
                 Value *scope_struct, std::vector<std::unique_ptr<ExprAST>> &Args, std::vector<Value*> &ArgsV) {
    Value *dest = Builder->CreateLoad(int8PtrTy, ArgsV[0]);
    Value *src = Builder->CreateLoad(int8PtrTy, ArgsV[1]);
    call("cudaMemcpy", {dest, src, ArgsV[2], const_int(1)});
    return const_int(0);
}
