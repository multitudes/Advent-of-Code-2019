//: [Previous](@previous)
//: [Next](@next)


import Foundation

var str = "Hello, playground"
public enum LCMError: Error {
    case divisionByZero
}
public func gcdRecursiveEuklid(_ m: Int, _ n: Int) -> Int {
    let r: Int = m % n
    if r != 0 {
        return gcdRecursiveEuklid(n, r)
    } else {
        return n
    }
}
public func gcdIterativeEuklid(_ m: Int, _ n: Int) -> Int {
    var a: Int = 0
    var b: Int = max(m, n)
    var r: Int = min(m, n)
    
    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}
func lcm(_ m: Int, _ n: Int, using gcdAlgorithm: (Int, Int) -> (Int) = gcdIterativeEuklid) throws -> Int {
guard (m & n) != 0 else { throw LCMError.divisionByZero }
return m / gcdAlgorithm(m, n) * n
}
do {
    try lcm(2, 3)   // 6
    try lcm(10, 8, using: gcdRecursiveEuklid)  // 40
} catch {
    dump(error)
}
