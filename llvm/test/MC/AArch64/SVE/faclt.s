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

faclt   p0.h, p0/z, z0.h, z1.h
// CHECK-INST: facgt	p0.h, p0/z, z1.h, z0.h
// CHECK-ENCODING: [0x30,0xe0,0x40,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 30 e0 40 65 <unknown>

faclt   p0.s, p0/z, z0.s, z1.s
// CHECK-INST: facgt	p0.s, p0/z, z1.s, z0.s
// CHECK-ENCODING: [0x30,0xe0,0x80,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 30 e0 80 65 <unknown>

faclt   p0.d, p0/z, z0.d, z1.d
// CHECK-INST: facgt	p0.d, p0/z, z1.d, z0.d
// CHECK-ENCODING: [0x30,0xe0,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 30 e0 c0 65 <unknown>
