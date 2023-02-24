// mlir-opt --affine-loop-normalize
// ...
// loop normalization: j (0, 300, 3) -> (0, 100, 1), j -> j * 3
// for (int j = 0; j < 100; j += 1)
affine.for %j = 0 to 100 step 1 {
  %j_new = affine.apply affine_map<(j) -> (j * 3)> (%j)

  // k += 2
  %k = memref.load %k_ptr[]       : memref<index>
  %k1 = arith.addi %k, %k_offset  : index
  memref.store %k1, %k_ptr[]      : memref<index>

  // U[j] = U[j] * W[k]
  %s1_uj = memref.load %U[%j_new]         : memref<?xi32>
  %s1_wk = memref.load %W[%k]         : memref<?xi32>
  %s1_r = arith.muli %s1_uj, %s1_wk   : i32
  memref.store %s1_r, %U[%j_new]          : memref<?xi32>

  // V[j + 3] = V[j] + W[k]
  %s2_vj = memref.load %V[%j_new]         : memref<?xi32>
  %s2_wk = memref.load %W[%k]         : memref<?xi32>
  %s2_r = arith.addi %s2_vj, %s2_wk   : i32
  %s2_j = arith.addi %j_new, %c3          : index
  memref.store %s2_r, %V[%s2_j]       : memref<?xi32>
}
//...
