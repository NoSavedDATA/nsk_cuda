#include "../../src/nsk_cpp_llvm.h"
#include "../../src/std/codegen.h"


extern "C" Value *float_cpu_int_offby(Parser_Struct parser_struct, Function *TheFunction,
           Data_Tree L_dt, Data_Tree R_dt,
           std::unique_ptr<ExprAST>& LHS,
           std::unique_ptr<ExprAST>& RHS,
           Value *scope_struct,
           Value *L, Value *R) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_cpu"])});
    Value *float_p = Builder->CreateLoad(floatTy->getPointerTo(), L);

    Builder->CreateStore(Builder->CreateGEP(floatTy, float_p, R),
                         ret);
    return ret; 
}

extern "C" Value *float_pp_int_offby(Parser_Struct parser_struct, Function *TheFunction,
           Data_Tree L_dt, Data_Tree R_dt,
           std::unique_ptr<ExprAST>& LHS,
           std::unique_ptr<ExprAST>& RHS,
           Value *scope_struct,
           Value *L, Value *R) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["float_cpu"])});
    Value *float_p = Builder->CreateLoad(floatTy->getPointerTo(), L);

    Builder->CreateStore(Builder->CreateGEP(floatTy, float_p, R),
                         ret);
    return ret; 
}



extern "C" Value *bf16_cpu_int_offby(Parser_Struct parser_struct, Function *TheFunction,
           Data_Tree L_dt, Data_Tree R_dt,
           std::unique_ptr<ExprAST>& LHS,
           std::unique_ptr<ExprAST>& RHS,
           Value *scope_struct,
           Value *L, Value *R) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["bf16_cpu"])});
    Value *float_p = Builder->CreateLoad(int16Ty->getPointerTo(), L);

    Builder->CreateStore(Builder->CreateGEP(int16Ty, float_p, R),
                         ret);
    return ret; 
}

extern "C" Value *bf16_pp_int_offby(Parser_Struct parser_struct, Function *TheFunction,
           Data_Tree L_dt, Data_Tree R_dt,
           std::unique_ptr<ExprAST>& LHS,
           std::unique_ptr<ExprAST>& RHS,
           Value *scope_struct,
           Value *L, Value *R) {
    Value *ret = callret("allocate_pool", {scope_struct, const_int(8), const_int16(data_name_to_type()["bf16_cpu"])});
    Value *float_p = Builder->CreateLoad(int16Ty->getPointerTo(), L);

    Builder->CreateStore(Builder->CreateGEP(int16Ty, float_p, R),
                         ret);
    return ret; 
}

