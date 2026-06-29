#include "../../src/nsk_cpp_llvm.h"
#include "../../src/std/codegen.h"



extern "C" Value *float_cpu_Store_Idx(Parser_Struct parser_struct, Function *TheFunction,
           Data_Tree L_dt, Data_Tree R_dt,
           std::unique_ptr<ExprAST>& LHS,
           std::unique_ptr<ExprAST>& RHS,
           Value *scope_struct,
           Value *L, Value *idx, Value *R) {
    std::string rtype = R_dt.Type;
    if (rtype!="float")
        R = Builder->CreateSIToFP(R, floatTy, "to_float");
    Value *float_p = Builder->CreateLoad(floatTy->getPointerTo(), L);
    Builder->CreateStore(R, Builder->CreateGEP(floatTy, float_p, idx));
    return const_int(0); 
}
