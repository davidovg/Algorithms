#find minimum distance between vertices in a graph - eg. correlation (i.e. symmetrical) matrix
#could be useful in clustering algorithms

findmin <- function(dd) {
  m = nrow(dd)
  dd = cbind(dd,1:m)
  row_mins<-apply(dd[-m,],1,findmin_row)
  row_minimum = which.min(row_mins[2,])
  col_minimum = row_mins[1,row_minimum]
  return(c(dd[row_minimum,col_minimum], row_minimum, col_minimum))  #outputs element, row and collumn
}


#auxiliary function to be applied on rows
findmin_row <- function(n) {
  lx = length(n)
  i = n[lx]
  j = which.min(n[(i+1):(lx-1)])
  k=j+i
  return(c(k,n[k])) 
}

my_matrix <-matrix((c(0,12,13,8,20,
                      12,0,15,28,88,
                      13,15,0,6,9,
                      8,28,6,0,33,
                      20,88,9,33,0)),nrow =5, byrow=T)

my_matrix

findmin(my_matrix)

