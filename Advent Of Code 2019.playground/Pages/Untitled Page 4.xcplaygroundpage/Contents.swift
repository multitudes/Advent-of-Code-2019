//: [Previous](@previous)



//: [Next](@next)

import Foundation

public func gcd(_ m: Int, _ n: Int) -> Int {
    let r: Int = m % n
    if r != 0 {
        return gcd(n, r)
    } else {
        return n
    }
}

public func gcd(_ numbers: Int...) -> Int {
    gcd(numbers)
}

public func gcd(_ numbers: [Int]) -> Int {
    numbers.reduce(0) { gcd($0, $1) }
}

public func lcm(_ m: Int, _ n: Int) -> Int {
    m / gcd(m, n) * n
}

public func lcm(_ numbers: Int...) -> Int {
    lcm(numbers)
}

public func lcm(_ numbers: [Int]) -> Int {
    numbers.reduce(numbers[0]) { lcm($0, $1) }
}

let a = 3
let b = 4
let c = [3,4,5,6]
let d = gcd(3,6)
let e = lcm(a,b, 24)
