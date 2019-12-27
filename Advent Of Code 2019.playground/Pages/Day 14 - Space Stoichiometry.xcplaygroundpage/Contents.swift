//: [Previous](@previous)
/*:
# Day 14: Space Stoichiometry

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   

 ## Part 2

 
 
: [Next](@next)
*/

import Foundation

public struct Nanofactory {
    public var reactions: [Quantity : [Quantity]]
}
public struct Reaction {
    public var inputs: [String: Int]
    public var output: String
    public var amount: Int
}

public struct Quantity: Hashable , Equatable {
    public static func == (lhs: Quantity, rhs: Quantity) -> Bool {
        return lhs.quantity == rhs.quantity
    }
    
    public var quantity: (chemical: String, quantity: Int)
    }
