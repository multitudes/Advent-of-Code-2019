//: [Previous](@previous)



//: [Next](@next)


var position = [ 2,  1, -3 ]
var b = position.compactMap { abs($0) }.reduce(0, +)

print(b)
