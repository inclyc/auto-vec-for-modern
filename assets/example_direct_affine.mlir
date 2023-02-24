func.func @example_direct_affine(%U: memref<?xi32>, %V: memref<?xi32>, %W: memref<?xi32>) {
  %k_offset = arith.constant 2 : index
  %c3 = arith.constant 3       : index

  // for (int i = 0; i < 100; i += 1)
  affine.for %i = 0 to 100 step 1 {
    // int k = i;
    %k_ptr = memref.alloc()             : memref<index>
    memref.store %i, %k_ptr[]           : memref<index>

    // for (int j = 0; j < 300; j += 3)
    affine.for %j = 0 to 300 step 3 {
      // k += 2
      %k = memref.load %k_ptr[]       : memref<index>
      %k1 = arith.addi %k, %k_offset  : index
      memref.store %k1, %k_ptr[]      : memref<index>

      // U[j] = U[j] * W[k]
      %s1_uj = memref.load %U[%j]         : memref<?xi32>
      %s1_wk = memref.load %W[%k]         : memref<?xi32>
      %s1_r = arith.muli %s1_uj, %s1_wk   : i32
      memref.store %s1_r, %U[%j]          : memref<?xi32>

      // V[j + 3] = V[j] + W[k]
      %s2_vj = memref.load %V[%j]         : memref<?xi32>
      %s2_wk = memref.load %W[%k]         : memref<?xi32>
      %s2_r = arith.addi %s2_vj, %s2_wk   : i32
      %s2_j = arith.addi %j, %c3          : index
      memref.store %s2_r, %V[%s2_j]       : memref<?xi32>
    }
  }

  func.return
}
