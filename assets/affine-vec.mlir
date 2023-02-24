func.func @example_affine_ab(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>) {
    affine.for %arg3 = 0 to 1000 step 16 {
        %c0_i32 = arith.constant 0 : i32
        %0 = vector.transfer_read %arg0[%arg3], %c0_i32 : memref<?xi32>, vector<16xi32>
        %c0_i32_0 = arith.constant 0 : i32
        %1 = vector.transfer_read %arg1[%arg3], %c0_i32_0 : memref<?xi32>, vector<16xi32>
        %2 = arith.addi %0, %1 : vector<16xi32>
        vector.transfer_write %2, %arg2[%arg3] : vector<16xi32>, memref<?xi32>
    }
    return
}
