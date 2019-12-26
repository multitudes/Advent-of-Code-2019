//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
var input = "1202, -1, 45, 594, 99"
var inputProgramArray = input.components(separatedBy: ",").compactMap { Int($0) }
print(inputProgramArray)
