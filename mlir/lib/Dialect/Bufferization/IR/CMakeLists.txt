add_mlir_dialect_library(MLIRBufferization
  AllocationOpInterface.cpp
  BufferizableOpInterface.cpp
  BufferizationOps.cpp
  BufferizationDialect.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/Bufferization

  DEPENDS
  MLIRAllocationOpInterfaceIncGen
  MLIRBufferizationOpsIncGen

  LINK_LIBS PUBLIC
  MLIRAffine
  MLIRDialect
  MLIRFunc
  MLIRIR
  MLIRTensor
  MLIRMemRef
  )
