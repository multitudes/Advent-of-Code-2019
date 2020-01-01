//: [Previous](@previous)
/*:
# Day 4: Secure Container

[See it on github](https://github.com/multitudes/Advent-of-Code-2019)

 You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password on a sticky note, but someone threw it out.

 However, they do remember a few key facts about the password:

 It is a six-digit number.
 The value is within the range given in your puzzle input.
 Two adjacent digits are the same (like 22 in 122345).
 Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
 Other than the range rule, the following are true:

 111111 meets these criteria (double 11, never decreases).
 223450 does not meet these criteria (decreasing pair of digits 50).
 123789 does not meet these criteria (no double).
 How many different passwords within the range given in your puzzle input meet these criteria?

 Your puzzle answer was 511.

 --- Part Two ---

 An Elf just remembered one more important detail: the two adjacent matching digits are not part of a larger group of matching digits.

 Given this additional criterion, but still ignoring the range rule, the following are now true:

 112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
 123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
 111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).
 How many different passwords within the range given in your puzzle input meet all of the criteria?

 Your puzzle answer was 316.
 
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
    // debug
    //print(digits)
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
