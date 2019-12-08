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
//let input = "788999-789999"
let boundary = input.components(separatedBy: "-")
// safe to force unwrap
let low = Int(boundary[0])!
let high = Int(boundary[1])!
// declare some vars
var flag = false; var double = false
var digits: [Int] = []
var passwords: [Int] = []
// loop over my potential passwords
outerloop: for i in low...high {
    flag = false ; double = false
    digits = i.digits
    for j in 1..<6 {
        if digits[j] == digits[j-1] { double = true }
        if digits[j] >= digits[j-1] { flag = true } else { continue outerloop }
    }
    if double == false { continue outerloop }
    print(digits)
    passwords.append(i)
}
let solution1 = passwords.count
print("Solution of part 1 is \(solution1)") // 511

// starting part 2

var passwordsPart2: [Int] = []
var count = 0
outerloop: for i in 0..<solution1 {
        double = false
        digits = passwords[i].digits
        count = 0
        // I start with the second digit and compare with first in the while
        var j = 1
        while j < 6 {
            while j < 6 && digits[j] == digits[j-1]  {
                count += 1
                // if double is already true then this is a secong double - break - dont need
                if count == 1 && double == true { break }
                // if count is bigger than one then it means it is bigger than a double! keep on looping but double is false
                if count > 1 { double = false } else { double = true }
                j += 1
                }
            // if I am here is because the current digit and previous are different so count is reset in case
            count = 0
            j += 1
            
        }
        if double == false { continue outerloop }
        passwordsPart2.append(passwords[i])
}


let solution2 = passwordsPart2.count
print("Solution of part 2 is \(solution2)")
//316
