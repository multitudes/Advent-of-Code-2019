//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
var input = "1202, -1, 45, 594, 99"
var inputProgramArray = input.components(separatedBy: ",").compactMap { Int($0) }
print(inputProgramArray)

let a = (1 * 1) % -1

var processingQueue = [String: Int]()
// this starts with fuel and quantity
processingQueue["FUEL"] = 1
let b = processingQueue.first
processingQueue["E"] = 1
let c = processingQueue.first
