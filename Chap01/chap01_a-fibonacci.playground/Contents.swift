import UIKit

print("~~~ Base Fibonacci function, unefficient ~~~\n")
// Fibonacci Serie: UNEFFICIENT: use small numbers only!!
func fibonacci(n: UInt) -> UInt {
    if (n < 2) {
        return n
    }
    
    return fibonacci(n: n - 2) + fibonacci(n: n - 1)
    
}

// 1 1 2 3 5 8 13 21 34 55
print("fibonacci(n:8) gives \(fibonacci(n: 8)).")


print("\n~~~ Fibonacci function that uses memoization, performant ~~~\n")
var fibMemo: [UInt: UInt] = [0: 0, 1: 1] // base cases

func fibonacciMemo (n: UInt) -> UInt {
    if let result = fibMemo[n] {
        return result
    } else {
        fibMemo[n] = fibonacciMemo(n: n-1) + fibonacciMemo(n: n-2)
    }
    
    return fibMemo[n]!
}

print("fibonacciMemo(n:8) gives \(fibonacciMemo(n: 8)).")

print("\n~~~ Fibonacci function that uses Iteration ~~~\n")
print("This version is even more performant.")
func fibonacciIter(n: UInt) -> UInt {
    if (n == 0) {
        return 0
    }
    
    // Tracking the two numbers
    var current: UInt = 0, next: UInt = 1
    
    for _ in 1 ..< n {
        (current, next) = (next, current + next)
    }
    
    return next
}

print("fibonacciIter(n:8) gives \(fibonacciIter(n: 8)).\n")

