//: [Previous](@previous)
/*:
# Day 4: Secure Container

[See it on github](https://github.com/multitudes/Advent-of-Code-2019)
You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password on a sticky note, but someone threw it out. &nbsp;
How many different passwords within the range given in your puzzle input meet these criteria?
[Next >](@next)
*/
import Foundation

// Your puzzle input is 359282-820401.
let input = "359282-820401"

let boundary = input.components(separatedBy: "-")
// safe to force unwrap
let low = Int(boundary[0])!
let high = Int(boundary[1])!
print(low, high)

