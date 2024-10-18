### Module 5: Doing Math in R ###
### Find the value of inverse of a matrix, determinant of a matrix by using the 
### following values:

# Define the matrices
A <- matrix(1:100, nrow=10)
B <- matrix(1:1000, nrow=10)

dim(A)

# use solve() to find the inverse of the matrices
solve(A)
# Error in solve.default(A) : 
# Lapack routine dgesv: system is exactly singular: U[6,6] = 0
# Matrix A has not inverse

solve(B)
# Error in solve.default(B) : 'a' (10 x 100) must be square
# Matrix of 1000 elements cannot be square therefore has no inverse
dim(B)


# use det() to find the determinant of the matrices
det(A)
det(B)