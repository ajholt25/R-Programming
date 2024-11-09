tukey_multiple <- function(x) { # x must be a df or matrix
  # create an array filled with TRUE values with same dimensions as x
  
  # add vector handling
  if(is.vector(x)){
    x <- as.matrix(x, ncol = 1)
  }
  
  outliers <- array(TRUE,dim=dim(x)) 
 
  
  for (j in 1:ncol(x)) # for j in 1 thru number of cols in x
  {
    # evaluates the first row of outliers and tukey.outlier for each column j 
    # and if true, assigns that to all rows of j
    # Note: tukey.outlier is not defined
    # && compares only first values
    outliers[,j] <- outliers[,j] & tukey_outliers(x[,j])
  }
  # define outlier.vec as a vector of same length as number of rows in x
  outlier.vec <- vector(length=nrow(x))
  
  for (i in 1:nrow(x)){  # for i in 1 thru number of rows in x
    # assign to outlier.vec index i, the logical result of testing if all logical
    # values in row i of outliers are true
    outlier.vec[i] <- all(outliers[i,]) 
    } 
  # return outlier.vec - single logical value
  return(outlier.vec)
  
  }
tukey_outliers <- function(x){
  # get the first and third quartiles
  quartiles <- quantile(x, probs = c(0.25, 0.75))
  tukeyLow <- quartiles[1]-1.5*IQR(x) # lower bound
  tukeyHigh <- quartiles[2]+1.5*IQR(x) # upper bound
  x <- (x < tukeyLow | x > tukeyHigh) # log vector true for outliers
  return(x)
  }