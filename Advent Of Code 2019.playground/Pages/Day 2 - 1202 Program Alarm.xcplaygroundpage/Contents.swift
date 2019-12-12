//: [Previous](@previous)
/*:
# Day 2: 1202 Program Alarm

[See it on github](https://github.com/multitudes/Advent-of-Code-2019)
 On the way to your gravity assist around the Moon, your ship computer beeps angrily about a "1202 program alarm"...
&nbsp;

[Next >](@next)
*/
import Foundation

// declaring the var containing the input
var input = ""

// this will look in my resources folder for the input.txt file
do {
    guard let fileUrl = Bundle.main.url(forResource: "input2", withExtension: "txt") else { fatalError() }
    input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
    print("input is: \(input)")
} catch {
    print(error)
}

//get the input file as an array into program
var program = input.components(separatedBy: ",").compactMap { Int($0) }

//before running the program, replace position 1 with the value 12 and replace position 2 with the value 2.
program[1] = 12
program[2] = 2

var index = 0

// the index will move at intervals of 4. I check everytime for the opcode 99 then I continue on the loop
while program[index] != 99 {
    // check for the other 2 opcodes
    switch program[index] {
    case 1:
        // will take the values in index plus one and index plus 2 add them and place in the position specified in 3
        program[program[index + 3]] = program[program[index + 1]] + program[program[index + 2]]
    case 2:
        // will take the values in index plus one and index plus 2, multiply them and place in the position specified in 3
        program[program[index + 3]] = program[program[index + 1]] * program[program[index + 2]]
    default:
        // this is not a valid opcode
        print("1202 program alarm")
    }
    // update the index for the next opcode
    index += 4
}
// exiting the loop and reading the position 0 of the program
print("the answer is : \(program[0])")
// the answer is : 4714701
