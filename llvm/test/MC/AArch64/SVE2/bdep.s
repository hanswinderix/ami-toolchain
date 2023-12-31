// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2-bitperm < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2-bitperm < %s \
// RUN:        | llvm-objdump -d --mattr=+sve2-bitperm - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2-bitperm < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

bdep z0.b, z1.b, z31.b
// CHECK-INST: bdep z0.b, z1.b, z31.b
// CHECK-ENCODING: [0x20,0xb4,0x1f,0x45]
// CHECK-ERROR: instruction requires: sve2-bitperm
// CHECK-UNKNOWN: 20 b4 1f 45 <unknown>

bdep z0.h, z1.h, z31.h
// CHECK-INST: bdep z0.h, z1.h, z31.h
// CHECK-ENCODING: [0x20,0xb4,0x5f,0x45]
// CHECK-ERROR: instruction requires: sve2-bitperm
// CHECK-UNKNOWN: 20 b4 5f 45 <unknown>

bdep z0.s, z1.s, z31.s
// CHECK-INST: bdep z0.s, z1.s, z31.s
// CHECK-ENCODING: [0x20,0xb4,0x9f,0x45]
// CHECK-ERROR: instruction requires: sve2-bitperm
// CHECK-UNKNOWN: 20 b4 9f 45 <unknown>

bdep z0.d, z1.d, z31.d
// CHECK-INST: bdep z0.d, z1.d, z31.d
// CHECK-ENCODING: [0x20,0xb4,0xdf,0x45]
// CHECK-ERROR: instruction requires: sve2-bitperm
// CHECK-UNKNOWN: 20 b4 df 45 <unknown>
