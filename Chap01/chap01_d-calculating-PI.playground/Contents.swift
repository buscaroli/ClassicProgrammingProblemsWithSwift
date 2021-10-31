import UIKit

/*
Calculating PI using Leibnitz formula

 pi = 4/1 - 4/3 + 4/5 - 4/7 + 4/9 - 4/11 ...

Numerator is constant
denominator starts at 1 and increases by 2
operation on the terms alternates between - and +
*/

func calculatePI(nTerms: UInt) -> Double {
    let numerator: Double = 4
    var denominator: Double = 1
    var operation: Double = -1
    var pi: Double = 0
    
    for _ in 0 ..< nTerms {
        pi += operation * numerator / denominator
        denominator += 2
        operation *= -1
    }
    
    return abs(pi)
}

print("The value of PI with 10000 terms is \(calculatePI(nTerms: 10000)).")
