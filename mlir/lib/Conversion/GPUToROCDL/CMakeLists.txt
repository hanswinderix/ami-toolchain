set(LLVM_TARGET_DEFINITIONS GPUToROCDL.td)
mlir_tablegen(GPUToROCDL.cpp.inc -gen-rewriters)
add_public_tablegen_target(MLIRGPUToROCDLIncGen)

add_mlir_conversion_library(MLIRGPUToROCDLTransforms
  LowerGpuOpsToROCDLOps.cpp

  DEPENDS
  MLIRConversionPassIncGen
  MLIRGPUToROCDLIncGen

  LINK_LIBS PUBLIC
  MLIRArithmeticToLLVM
  MLIRAMDGPUToROCDL
  MLIRFuncToLLVM
  MLIRGPUOps
  MLIRGPUToGPURuntimeTransforms
  MLIRLLVMCommonConversion
  MLIRLLVMIR
  MLIRMemRefToLLVM
  MLIRROCDLIR
  MLIRPass
  MLIRVectorToROCDL
  )
