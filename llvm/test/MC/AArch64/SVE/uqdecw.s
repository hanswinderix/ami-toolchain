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


// ---------------------------------------------------------------------------//
// Test 64-bit form (x0) and its aliases
// ---------------------------------------------------------------------------//
uqdecw  x0
// CHECK-INST: uqdecw  x0
// CHECK-ENCODING: [0xe0,0xff,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 ff b0 04 <unknown>

uqdecw  x0, all
// CHECK-INST: uqdecw  x0
// CHECK-ENCODING: [0xe0,0xff,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 ff b0 04 <unknown>

uqdecw  x0, all, mul #1
// CHECK-INST: uqdecw  x0
// CHECK-ENCODING: [0xe0,0xff,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 ff b0 04 <unknown>

uqdecw  x0, all, mul #16
// CHECK-INST: uqdecw  x0, all, mul #16
// CHECK-ENCODING: [0xe0,0xff,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 ff bf 04 <unknown>


// ---------------------------------------------------------------------------//
// Test 32-bit form (w0) and its aliases
// ---------------------------------------------------------------------------//

uqdecw  w0
// CHECK-INST: uqdecw  w0
// CHECK-ENCODING: [0xe0,0xff,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 ff a0 04 <unknown>

uqdecw  w0, all
// CHECK-INST: uqdecw  w0
// CHECK-ENCODING: [0xe0,0xff,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 ff a0 04 <unknown>

uqdecw  w0, all, mul #1
// CHECK-INST: uqdecw  w0
// CHECK-ENCODING: [0xe0,0xff,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 ff a0 04 <unknown>

uqdecw  w0, all, mul #16
// CHECK-INST: uqdecw  w0, all, mul #16
// CHECK-ENCODING: [0xe0,0xff,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 ff af 04 <unknown>

uqdecw  w0, pow2
// CHECK-INST: uqdecw  w0, pow2
// CHECK-ENCODING: [0x00,0xfc,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 fc a0 04 <unknown>

uqdecw  w0, pow2, mul #16
// CHECK-INST: uqdecw  w0, pow2, mul #16
// CHECK-ENCODING: [0x00,0xfc,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 fc af 04 <unknown>


// ---------------------------------------------------------------------------//
// Test vector form and aliases.
// ---------------------------------------------------------------------------//
uqdecw  z0.s
// CHECK-INST: uqdecw  z0.s
// CHECK-ENCODING: [0xe0,0xcf,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 cf a0 04 <unknown>

uqdecw  z0.s, all
// CHECK-INST: uqdecw  z0.s
// CHECK-ENCODING: [0xe0,0xcf,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 cf a0 04 <unknown>

uqdecw  z0.s, all, mul #1
// CHECK-INST: uqdecw  z0.s
// CHECK-ENCODING: [0xe0,0xcf,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 cf a0 04 <unknown>

uqdecw  z0.s, all, mul #16
// CHECK-INST: uqdecw  z0.s, all, mul #16
// CHECK-ENCODING: [0xe0,0xcf,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 cf af 04 <unknown>

uqdecw  z0.s, pow2
// CHECK-INST: uqdecw  z0.s, pow2
// CHECK-ENCODING: [0x00,0xcc,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 cc a0 04 <unknown>

uqdecw  z0.s, pow2, mul #16
// CHECK-INST: uqdecw  z0.s, pow2, mul #16
// CHECK-ENCODING: [0x00,0xcc,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 cc af 04 <unknown>


// ---------------------------------------------------------------------------//
// Test all patterns for 64-bit form
// ---------------------------------------------------------------------------//

uqdecw  x0, pow2
// CHECK-INST: uqdecw  x0, pow2
// CHECK-ENCODING: [0x00,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 fc b0 04 <unknown>

uqdecw  x0, vl1
// CHECK-INST: uqdecw  x0, vl1
// CHECK-ENCODING: [0x20,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 20 fc b0 04 <unknown>

uqdecw  x0, vl2
// CHECK-INST: uqdecw  x0, vl2
// CHECK-ENCODING: [0x40,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 40 fc b0 04 <unknown>

uqdecw  x0, vl3
// CHECK-INST: uqdecw  x0, vl3
// CHECK-ENCODING: [0x60,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 60 fc b0 04 <unknown>

uqdecw  x0, vl4
// CHECK-INST: uqdecw  x0, vl4
// CHECK-ENCODING: [0x80,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 80 fc b0 04 <unknown>

uqdecw  x0, vl5
// CHECK-INST: uqdecw  x0, vl5
// CHECK-ENCODING: [0xa0,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a0 fc b0 04 <unknown>

uqdecw  x0, vl6
// CHECK-INST: uqdecw  x0, vl6
// CHECK-ENCODING: [0xc0,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: c0 fc b0 04 <unknown>

uqdecw  x0, vl7
// CHECK-INST: uqdecw  x0, vl7
// CHECK-ENCODING: [0xe0,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 fc b0 04 <unknown>

uqdecw  x0, vl8
// CHECK-INST: uqdecw  x0, vl8
// CHECK-ENCODING: [0x00,0xfd,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 fd b0 04 <unknown>

uqdecw  x0, vl16
// CHECK-INST: uqdecw  x0, vl16
// CHECK-ENCODING: [0x20,0xfd,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 20 fd b0 04 <unknown>

uqdecw  x0, vl32
// CHECK-INST: uqdecw  x0, vl32
// CHECK-ENCODING: [0x40,0xfd,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 40 fd b0 04 <unknown>

uqdecw  x0, vl64
// CHECK-INST: uqdecw  x0, vl64
// CHECK-ENCODING: [0x60,0xfd,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 60 fd b0 04 <unknown>

uqdecw  x0, vl128
// CHECK-INST: uqdecw  x0, vl128
// CHECK-ENCODING: [0x80,0xfd,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 80 fd b0 04 <unknown>

uqdecw  x0, vl256
// CHECK-INST: uqdecw  x0, vl256
// CHECK-ENCODING: [0xa0,0xfd,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a0 fd b0 04 <unknown>

uqdecw  x0, #14
// CHECK-INST: uqdecw  x0, #14
// CHECK-ENCODING: [0xc0,0xfd,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: c0 fd b0 04 <unknown>

uqdecw  x0, #15
// CHECK-INST: uqdecw  x0, #15
// CHECK-ENCODING: [0xe0,0xfd,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 fd b0 04 <unknown>

uqdecw  x0, #16
// CHECK-INST: uqdecw  x0, #16
// CHECK-ENCODING: [0x00,0xfe,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 fe b0 04 <unknown>

uqdecw  x0, #17
// CHECK-INST: uqdecw  x0, #17
// CHECK-ENCODING: [0x20,0xfe,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 20 fe b0 04 <unknown>

uqdecw  x0, #18
// CHECK-INST: uqdecw  x0, #18
// CHECK-ENCODING: [0x40,0xfe,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 40 fe b0 04 <unknown>

uqdecw  x0, #19
// CHECK-INST: uqdecw  x0, #19
// CHECK-ENCODING: [0x60,0xfe,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 60 fe b0 04 <unknown>

uqdecw  x0, #20
// CHECK-INST: uqdecw  x0, #20
// CHECK-ENCODING: [0x80,0xfe,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 80 fe b0 04 <unknown>

uqdecw  x0, #21
// CHECK-INST: uqdecw  x0, #21
// CHECK-ENCODING: [0xa0,0xfe,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a0 fe b0 04 <unknown>

uqdecw  x0, #22
// CHECK-INST: uqdecw  x0, #22
// CHECK-ENCODING: [0xc0,0xfe,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: c0 fe b0 04 <unknown>

uqdecw  x0, #23
// CHECK-INST: uqdecw  x0, #23
// CHECK-ENCODING: [0xe0,0xfe,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 fe b0 04 <unknown>

uqdecw  x0, #24
// CHECK-INST: uqdecw  x0, #24
// CHECK-ENCODING: [0x00,0xff,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 ff b0 04 <unknown>

uqdecw  x0, #25
// CHECK-INST: uqdecw  x0, #25
// CHECK-ENCODING: [0x20,0xff,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 20 ff b0 04 <unknown>

uqdecw  x0, #26
// CHECK-INST: uqdecw  x0, #26
// CHECK-ENCODING: [0x40,0xff,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 40 ff b0 04 <unknown>

uqdecw  x0, #27
// CHECK-INST: uqdecw  x0, #27
// CHECK-ENCODING: [0x60,0xff,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 60 ff b0 04 <unknown>

uqdecw  x0, #28
// CHECK-INST: uqdecw  x0, #28
// CHECK-ENCODING: [0x80,0xff,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 80 ff b0 04 <unknown>


// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 bc 20 04 <unknown>

uqdecw  z0.s
// CHECK-INST: uqdecw	z0.s
// CHECK-ENCODING: [0xe0,0xcf,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 cf a0 04 <unknown>

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 bc 20 04 <unknown>

uqdecw  z0.s, pow2, mul #16
// CHECK-INST: uqdecw	z0.s, pow2, mul #16
// CHECK-ENCODING: [0x00,0xcc,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 cc af 04 <unknown>

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e0 bc 20 04 <unknown>

uqdecw  z0.s, pow2
// CHECK-INST: uqdecw	z0.s, pow2
// CHECK-ENCODING: [0x00,0xcc,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 00 cc a0 04 <unknown>
