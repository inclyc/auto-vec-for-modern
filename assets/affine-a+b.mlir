// mlir-opt --affine-super-vectorize='virtual-vector-size=256 test-fastest-varying=0' example.mlir
func.func @example_affine_ab(%A: memref<?xi32>, %B: memref<?xi32>, %C: memref<?xi32>) {
    affine.for %arg0 = 0 to 1000 {
        %0 = affine.load %A[%arg0] : memref<?xi32>
        %1 = affine.load %B[%arg0] : memref<?xi32>
        %2 = arith.addi %0, %1 : i32
        affine.store %2, %C[%arg0] : memref<?xi32>
    }
    return
}
