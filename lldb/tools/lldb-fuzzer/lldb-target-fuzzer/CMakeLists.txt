set(LLVM_LINK_COMPONENTS
  Support
  )

add_llvm_fuzzer(lldb-target-fuzzer
  EXCLUDE_FROM_ALL
  lldb-target-fuzzer.cpp
  )

if(TARGET lldb-target-fuzzer)
  target_include_directories(lldb-target-fuzzer PRIVATE ..)
  target_link_libraries(lldb-target-fuzzer
    PRIVATE
    liblldb
    lldbFuzzerUtils
    )
endif()
