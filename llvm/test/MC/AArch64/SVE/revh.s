// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d --mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

revh  z0.s, p7/m, z31.s
// CHECK-INST: revh	z0.s, p7/m, z31.s
// CHECK-ENCODING: [0xe0,0x9f,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 9f a5 05 <unknown>

revh  z0.d, p7/m, z31.d
// CHECK-INST: revh	z0.d, p7/m, z31.d
// CHECK-ENCODING: [0xe0,0x9f,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 9f e5 05 <unknown>


// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z0.d, p7/z, z7.d
// CHECK-INST: movprfx	z0.d, p7/z, z7.d
// CHECK-ENCODING: [0xe0,0x3c,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 3c d0 04 <unknown>

revh  z0.d, p7/m, z31.d
// CHECK-INST: revh	z0.d, p7/m, z31.d
// CHECK-ENCODING: [0xe0,0x9f,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 9f e5 05 <unknown>

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 bc 20 04 <unknown>

revh  z0.d, p7/m, z31.d
// CHECK-INST: revh	z0.d, p7/m, z31.d
// CHECK-ENCODING: [0xe0,0x9f,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 9f e5 05 <unknown>
