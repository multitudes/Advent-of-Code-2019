//: [Previous](@previous)
/*:
# Day 5 - Sunny with a Chance of Asteroids

[See it on github](https://github.com/multitudes/Advent-of-Code-2019)
 
You're starting to sweat as the ship makes its way toward Mercury. The Elves suggest that you get the air conditioner working by upgrading your ship computer to support the Thermal Environment Supervision Terminal.
[...]
Finally, the program will output a diagnostic code and immediately halt. This final output isn't an error; an output followed immediately by a halt means the program finished. If all outputs were zero except the diagnostic code, the diagnostic program ran successfully. After providing 1 to the only input instruction and passing all the tests, what diagnostic code does the program produce?
 
[Next >](@next)
*/

import Foundation
// declaring the var containing the input
var input = ""

// this will look in my resources folder for the input.txt file
do {
    guard let fileUrl = Bundle.main.url(forResource: "input5", withExtension: "txt") else { fatalError() }
    input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
    print("input is: \(input)")
} catch {
    print(error)
}

//get the input file as an array into program
var program = input.components(separatedBy: ",").compactMap { Int($0) }
// Possible opcodes in an Intcode program.
public enum Opcode: Int {
    case add = 1,
        multiply = 2,
        input = 3,
        output = 4,
        halt = 99
}
// Possible modes for a parameter in an Intcode program.
enum Mode: Int {
    case position = 0,
        immediate = 1

}
// the instruction will be ABCDE the last two digit the opcodes and the rest parameters
struct Instruction {
    let opcode: Opcode
    var parameters: [Int]
    // +1 for the opcode
    var length: Int { return parameters.count + 1 }
}
public func writeInput(input: Int, location: Int) {
    program[location] = input
}
var inputParam = 0
var index = 0
var writeTo = 0
var firstParam = 0
var secondParam = 0
//
// the index will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
while program[index] != 99 {
//for i in 0..<6{
    var mode = Mode(rawValue: 0)
    var instruction = Instruction(opcode: Opcode(rawValue: program[index] % 100)!, parameters: [])
    instruction.parameters = [ (program[index] % 1000 / 100), program[index] / 1000 ]
    print("instruction: \(program[index])")
    switch instruction.opcode {
        case .add:
            print("add! got it")
            mode = Mode(rawValue: 0)
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            if instruction.parameters[0] == 0 {
                firstParam = program[program[index + 1]]
            } else {
                firstParam = program[index + 1]
            }
            if instruction.parameters[1] == 0 {
                secondParam = program[program[index + 2]]
            } else {
                secondParam = program[index + 2]
            }
            writeTo = program[index + 3]
            program[writeTo] = firstParam + secondParam
            print("value: \(firstParam) + \(secondParam) = \(firstParam + secondParam) written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            index += 4
        case .multiply:
            print("multiply ")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            if instruction.parameters[0] == 0 {
                firstParam = program[program[index + 1]]
            } else {
                firstParam = program[index + 1]
            }
            if instruction.parameters[1] == 0 {
                secondParam = program[program[index + 2]]
            } else {
                secondParam = program[index + 2]
            }
            program[program[index + 3]] = firstParam * secondParam
            print("value: \(firstParam) * \(secondParam) = \(firstParam * secondParam) written to \(program[index + 3])\n")
            index += 4
        case .input:
            print(" TEST Input: 1 ")
            // readLine does not work in Playgrounds 😅 I will hardcode it to 1
            writeInput(input: 1, location: program[index + 1])
            index += 2
        case .output:
            var firstParam:Int {return instruction.parameters[0] == 0 ? program[program[index + 1]] : program[index + 1]}
            print("output got: \(firstParam)")
            index += 2
        case .halt:
            print("stop")
        
    }
    //print("instruction: \(program[index])")
    
    
    }
//    // check for the other 2 opcodes
//    switch program[index] {
//    case 1:
//        // will take the values in index plus one and index plus 2 add them and place in the position specified in 3
//        program[program[index + 3]] = program[program[index + 1]] + program[program[index + 2]]
//    case 2:
//        // will take the values in index plus one and index plus 2, multiply them and place in the position specified in 3
//        program[program[index + 3]] = program[program[index + 1]] * program[program[index + 2]]
//    default:
//        // this is not a valid opcode
//        print("1202 program alarm")
//    }
//    // update the index for the next opcode
//    index += 4
//}

