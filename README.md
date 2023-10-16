# matrix_multiplier_v1
This repository contains two different hardware implementations of a 16-bit matrix multiplier:
1. `v0` takes 16 clock cycles to multiply two matrices
2. `v1` takes 4 clock cycles to multiply two matrices
   
**v1** uses two optimization techniques to achieve the 4 clock cycle target:
1. Loop unrolling
2. Operation chaining
