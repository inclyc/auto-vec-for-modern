// translate memref.load/store into affine.load/store
func.func @example_affine_mem(%U: memref<?xi32>, %V: memref<?xi32>, %W: memref<?xi32>) {
  // for (int i = 0; i < 100; i++)
  affine.for %i = 0 to 100 {
    // for (int j = 0; j < 100; j += 1)
    affine.for %j = 0 to 100 {
      // U[3*j] = U[3*j] * W[2*j + i]
      %s1_uj = affine.load %U[3 * %j]         : memref<?xi32>
      %s1_wk = affine.load %W[2 * %j + %i]    : memref<?xi32>
      %s1_r = arith.muli %s1_uj, %s1_wk       : i32
      affine.store %s1_r, %U[3 * %j]          : memref<?xi32>

      // V[3*j + 3] = V[3*j] + W[2*j + i]
      %s2_vj = affine.load %V[3 * %j]         : memref<?xi32>
      %s2_wk = affine.load %W[2 * %j + %i]    : memref<?xi32>
      %s2_r = arith.addi %s2_vj, %s2_wk       : i32
      affine.store %s2_r, %V[3 * %j + 3]      : memref<?xi32>
    }
  }
  func.return
}
