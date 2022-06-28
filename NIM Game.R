zarezdane <- function(a) {                                           # Initial arranging - number of columns
  a <- c()                                                           # with coins
  cat("Numbers of columns: ", "\n"); kol <- scan(n=1)                # Loop for selecting number of coins
  for ( i in 1:kol) {                                                # in every column
    cat("Number of coins in column", i, "\n"); mon <- scan(n=1)      # This should be executed before the rest of code
    a <- c(a, mon)}                                                  #
  return(a)}                                                         #
a <- zarezdane(a)

max <- a[1]                       # Finds the biggest number
n <- length(a)                    # in the vector
for (i in 1:n)                    # with initial values
  if (a[i] > max) max <- a[i]    

l <- max; br1 <- 0                           # finds the length of
while (l > 0) {l <- l %/% 2; br1 <- br1 + 1} # of the binary representation of the biggest number

base <- c()                                            # In matrix m         
for (i in n:1)                                         # saves the binary
  for (j in 1:br1) {                                  # reprs. of our data
    base <- c((a[i] %% 2), base); a[i] <- a[i] %/% 2} # a[i,j] j 1:br1 is
m <- matrix(base, br1, n)                              # binary code of ith number 

vhod <- function(m) {                         # This function gives the move 
  a <- c()                                    # of the opponent. In local array
  for (i in 1:n) {                            #  , determines current situation
    s <- 0                                    # Expects the number of column v1 
    for (j in 1:br1) {s <- s*2 + m[j, i]}     # and number of taken coins
    a <- c(a, s)}                               #
  print(a)                                    # coins. Checks correctness
  v1 <- n+1                                   # - whether the number of the
  while(v1 > n) {                             # column exists and whether
    cat("\n","column","\n"); v1 <- scan(n=1)} # it has certain number of coins. 
  v2 <- max+1                                 # Sets in matrix m 
  while(v2 > a[v1]) {                         # our new case.
    cat("\n","number (less than ", a[v1]+1, " but bigger than 0)", "\n"); v2 <- scan(n=1)}   #
  a[v1] <- a[v1] - v2
  b <- a[v1]                         
  for (i in br1:1) {m[i, v1] <- b %% 2; b <- b %/% 2}
  return(m)} 

otgovor <- function(m) {  # Main program
  m <- vhod(m)           # Input -move of the player
  a <- c()                                # Calls the vector with  
  for (i in 1:n) {                           
    s <- 0                                  # the given number  
    for (j in 1:br1) {s <- s*2 + m[j, i]}   #  
    a <- c(a, s)}                           # of coins in the heaps
  na <- 0; k <- 0                                            # Finds the number of the heap
  for (i in 1:length(a)) if (a[i] > na) {na <- a[i]; k <- i} # and the number of coins, where they are most
  br2 <- 0                                                # Find the numbers of non-zero heaps 
  for (i in 1:length(a)) {if (a[i] != 0) br2 <- br2 + 1}  # heaps
  if (br2 == 0) {print("Meine Damen und Herren, I lost"); return()}  # If all of them are zeros - no move
  if (br2 == 1) {print("Meine Damen und Herren, I won"); return()}  # If only one is none zero - I take all and I'm   a winner
  else {
    c <- c()                              # otherwise it finds vector c 
    for (i in 1:br1) {                    
      c <- c(c, 0)                       # from 0 to 1
      for (j in 1:length(a)) {           
        c[i] <- c[i]+m[i,j]}            
      c[i] <- c[i] %% 2}                 
    s <- 0
    for (i in 1:br1) if (c[i] == 1) s <- s+1 # computes the number of 1s in c
    if (s == 0) {  # If it is 0 - there's no winning strategy
      cat("I choose column", k, "all of them, please press enter", "\n"); scan (n=1);
      for (i in 1:br1) m[i,k] <- 0  # I take all coins in the biggest heap
      m <- otgovor(m)}              # In the new situation , everything is repeated
    else {
      i <- 1; r <- i                                # Finds the position
      while (c[i] == 0) {i <- i+1; r <- i}          # of the first 1 in c
        i <- 1; q <- i                                # finds the 1st heap,in the binary representation
      while (m[r, i] == 0) {i <- i+1; q <- i}       #  of which on this position is 1
        hod1 <- 0 
      for (i in 1:br1) hod1 <- hod1*2 + m[i, q]     # Inputs the new number                  for (i in 1:br1) hod1 <- hod1*2 + m[i, q]     #
      for (i in 1:br1) if (c[i] == 1) m[i, q] <- 1  # coins
      m[r, q] <- 0                                  #
      hod2 <- 0                                     # in the so found heap
      for (i in 1:br1) hod2 <- hod2*2 + m[i, q]     #
      hod <- hod1 - hod2                            # Number, which we must take 
      cat("I choose column", q, "  ", hod, "coin(s),please press enter",  "\n"); scan(n=1);
      m <- otgovor(m)}}  # in the new situation - again (recursion)
  return(m)}


m <- otgovor(m)
