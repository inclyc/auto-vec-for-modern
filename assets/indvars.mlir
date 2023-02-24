// maybe need a "mem2reg" pass to make %k a iter_arg of affine.for first?
// ...
// indation variable: k = 2j + i
%k = affine.apply affine_map<(i, j) -> (2 * j + i)> (%i, %j)

// U[j] = U[j] * W[k]
%s1_uj = memref.load %U[%j_new]         : memref<?xi32>
%s1_wk = memref.load %W[%k]         : memref<?xi32>
%s1_r = arith.muli %s1_uj, %s1_wk   : i32
memref.store %s1_r, %U[%j_new]          : memref<?xi32>

//...
