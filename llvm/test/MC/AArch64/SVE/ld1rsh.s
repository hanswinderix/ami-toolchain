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

ld1rsh  { z0.s }, p0/z, [x0]
// CHECK-INST: ld1rsh  { z0.s }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x40,0x85]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 a0 40 85 <unknown>

ld1rsh  { z0.d }, p0/z, [x0]
// CHECK-INST: ld1rsh  { z0.d }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0x80,0x40,0x85]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 80 40 85 <unknown>

ld1rsh  { z31.s }, p7/z, [sp, #126]
// CHECK-INST: ld1rsh  { z31.s }, p7/z, [sp, #126]
// CHECK-ENCODING: [0xff,0xbf,0x7f,0x85]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: ff bf 7f 85 <unknown>

ld1rsh  { z31.d }, p7/z, [sp, #126]
// CHECK-INST: ld1rsh  { z31.d }, p7/z, [sp, #126]
// CHECK-ENCODING: [0xff,0x9f,0x7f,0x85]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: ff 9f 7f 85 <unknown>
