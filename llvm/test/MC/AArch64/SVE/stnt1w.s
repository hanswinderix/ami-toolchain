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

stnt1w  z0.s, p0, [x0]
// CHECK-INST: stnt1w  { z0.s }, p0, [x0]
// CHECK-ENCODING: [0x00,0xe0,0x10,0xe5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 e0 10 e5 <unknown>

stnt1w  { z0.s }, p0, [x0]
// CHECK-INST: stnt1w  { z0.s }, p0, [x0]
// CHECK-ENCODING: [0x00,0xe0,0x10,0xe5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 e0 10 e5 <unknown>

stnt1w  { z23.s }, p3, [x13, #-8, mul vl]
// CHECK-INST: stnt1w  { z23.s }, p3, [x13, #-8, mul vl]
// CHECK-ENCODING: [0xb7,0xed,0x18,0xe5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: b7 ed 18 e5 <unknown>

stnt1w  { z21.s }, p5, [x10, #7, mul vl]
// CHECK-INST: stnt1w  { z21.s }, p5, [x10, #7, mul vl]
// CHECK-ENCODING: [0x55,0xf5,0x17,0xe5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 55 f5 17 e5 <unknown>

stnt1w  { z0.s }, p0, [x0, x0, lsl #2]
// CHECK-INST: stnt1w  { z0.s }, p0, [x0, x0, lsl #2]
// CHECK-ENCODING: [0x00,0x60,0x00,0xe5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 60 00 e5 <unknown>
