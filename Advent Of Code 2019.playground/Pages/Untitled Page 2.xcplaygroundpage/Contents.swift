//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
var count = 0
for _ in 0..<1_000_000_000 {
    count += 1
    if count % 100_000 == 0 {
        // print only every 100_000th loop iteration
        print(count)
    }
}
