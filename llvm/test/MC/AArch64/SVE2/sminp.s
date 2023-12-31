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

sminp z0.b, p0/m, z0.b, z1.b
// CHECK-INST: sminp z0.b, p0/m, z0.b, z1.b
// CHECK-ENCODING: [0x20,0xa0,0x16,0x44]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 20 a0 16 44 <unknown>

sminp z0.h, p0/m, z0.h, z1.h
// CHECK-INST: sminp z0.h, p0/m, z0.h, z1.h
// CHECK-ENCODING: [0x20,0xa0,0x56,0x44]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: 20 a0 56 44 <unknown>

sminp z29.s, p7/m, z29.s, z30.s
// CHECK-INST: sminp z29.s, p7/m, z29.s, z30.s
// CHECK-ENCODING: [0xdd,0xbf,0x96,0x44]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: dd bf 96 44 <unknown>

sminp z31.d, p7/m, z31.d, z30.d
// CHECK-INST: sminp z31.d, p7/m, z31.d, z30.d
// CHECK-ENCODING: [0xdf,0xbf,0xd6,0x44]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: df bf d6 44 <unknown>

// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z31.d, p0/z, z6.d
// CHECK-INST: movprfx z31.d, p0/z, z6.d
// CHECK-ENCODING: [0xdf,0x20,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: df 20 d0 04 <unknown>

sminp z31.d, p0/m, z31.d, z30.d
// CHECK-INST: sminp z31.d, p0/m, z31.d, z30.d
// CHECK-ENCODING: [0xdf,0xa3,0xd6,0x44]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: df a3 d6 44 <unknown>

movprfx z31, z6
// CHECK-INST: movprfx z31, z6
// CHECK-ENCODING: [0xdf,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: df bc 20 04 <unknown>

sminp z31.d, p7/m, z31.d, z30.d
// CHECK-INST: sminp z31.d, p7/m, z31.d, z30.d
// CHECK-ENCODING: [0xdf,0xbf,0xd6,0x44]
// CHECK-ERROR: instruction requires: sve2 or sme
// CHECK-UNKNOWN: df bf d6 44 <unknown>
