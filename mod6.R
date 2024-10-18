# Mod 6 Assignment: Math in R Part 2
#

# Enter the matrices
A <- matrix(c(2, 0, 1, 3), ncol = 2)
B <- matrix(c(5, 2, 4, -1), ncol = 2)

# Add & Subtract matrices
A + B  # element-wise addition

# A + B is the matrix of
c(2, 0, 1, 3) +
c(5, 2, 4, -1)

A - B  # element-wise subtraction

# A - B is the same as
c(2, 0, 1, 3) -
c(5, 2, 4, -1)  

# diagonal matrices
C <- c(4, 1, 2, 3) # create the vector of diagonal values
diag(C, nrow = 4) # create the diagonal matrix

D <- diag(3, nrow = 5) # create a diagonal matrix with single integer
D[2:5, 1] <- 2 # modify the first column except for the diagonal
D[1, 2:5] <- 1 # modify the first row except for the diagonal