// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2 < %s \
// RUN:        | llvm-objdump -d --mattr=+sve2 - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2 < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN


saddlbt z0.h, z1.b, z31.b
// CHECK-INST: saddlbt	z0.h, z1.b, z31.b
// CHECK-ENCODING: [0x20,0x80,0x5f,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 20 80 5f 45 <unknown>

saddlbt z0.s, z1.h, z31.h
// CHECK-INST: saddlbt	z0.s, z1.h, z31.h
// CHECK-ENCODING: [0x20,0x80,0x9f,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 20 80 9f 45 <unknown>

saddlbt z0.d, z1.s, z31.s
// CHECK-INST: saddlbt	z0.d, z1.s, z31.s
// CHECK-ENCODING: [0x20,0x80,0xdf,0x45]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 20 80 df 45 <unknown>
