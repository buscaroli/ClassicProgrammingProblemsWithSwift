import UIKit

/* Tower of Hanoi */

public class Stack<T>: CustomStringConvertible {
    private var container: [T] = [T]()
    public var description: String { return container.description }
    
    public func push(_ element: T) { container.append(element) }
    public func pop() -> T { return container.removeLast() }
}

let numDiscs = 3
var towerA = Stack<Int>()
var towerB = Stack<Int>()
var towerC = Stack<Int>()


for i in 1...numDiscs {
    towerA.push(i)
}

towerA.description

func hanoi(from: Stack<Int>, to: Stack<Int>, temp: Stack<Int>, n: Int) {
    if n == 1 {
        to.push(from.pop())
    } else {
        hanoi(from: from, to: temp, temp: to, n: n-1)
        hanoi(from: from, to: to, temp: temp, n: 1)
        hanoi(from: temp, to: to, temp: from, n: n-1)
        print("A: \(towerA)")
        print("B: \(towerB)")
        print("C: \(towerC)\n")
    }
    
}

print("A: \(towerA)")
print("B: \(towerB)")
print("C: \(towerC)\n")
hanoi(from: towerA, to: towerC, temp: towerB, n: numDiscs)

/*
 - A is from (first tower)
 - C is to (third tower)
 - B is temp (middle tower)
 
 1. Base Case: move from A to C
 2. Recurrent Case:
    - Call func from A to B using C as a temp tower
    - Call func from B to C using A as a temp tower
 */
func hanoi2(from: String, to: String, temp: String, n: Int) {
    if n == 1 {
        print("Move disk 1 from \(from) to \(to).")
    } else {
        hanoi2(from: from, to: temp, temp: to, n: n-1)
        print("Move disk \(n) from \(from) to \(to).")
        hanoi2(from: temp, to: to, temp: from, n: n-1)
    }
}

let numOfTowers = 4
hanoi2(from: "A", to: "C", temp: "B", n: numOfTowers)
