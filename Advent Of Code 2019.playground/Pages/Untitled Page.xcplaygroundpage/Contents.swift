//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

enum Color: Int {
    case black = 0,
        white = 1,
        transparent = 2
}
let a : Color = Color(rawValue: 3) ?? .transparent

if a == .white { print("d")}
if a == .transparent { print("transparent")}
