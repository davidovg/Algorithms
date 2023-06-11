#more efficient recursive way to compute Fibonacci
from typing import Dict
memo: Dict[int, int] = {0: 0, 1: 1}

def fib3(n: int) -> int:
    if n not in memo:
        memo[n] = fib3(n-1)+fib3(n-2)
    return memo[n]

#even better without explicit memo
from functools import lru_cache
@lru_cache(maxsize=None)

def fib4(n: int) -> int:
    if n < 2: #base case
        return n
    return fib4(n-2)+fib4(n-1)

#fib3(50)

#with generator
from typing import Generator
def fib6(n: int) -> Generator[int, None, None]:
    yield 0 #special case
    if n>0: yield 1
    last: int = 0 #fib0
    next: int = 1 #fib1
    for _ in range(1, n):
        last, next = next, last + next
        yield next

for i in fib6(50):
    print(i)

#and the most effective way is the simplest
def fibb(n: int) -> int:
    last: int = 0
    next: int = 1
    for _ in range(n):
        last, next = next, last + next
    return next