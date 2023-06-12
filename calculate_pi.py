#calculates pi by applying Leibniz formula
def calculate_pi(precision):
    numerator: float = 4.0
    denominator: float = 1.0
    operation: float = 1.0
    pi: float = 0.0
    error = 3.14159265 - pi
    n_terms: int = 0
    while (error>precision):
        pi += operation * (numerator/denominator)
        denominator += 2.0
        operation *= -1.0
        n_terms += 1
        error = abs(3.14159265 - pi)
    print('to get precision of {} you will need {} terms to get {}'.format(precision,n_terms,pi))

#calculate_pi(0.00005)