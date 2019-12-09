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

// func getInput is in utilities file
var input = getInput(inputFile: "input5", extension: "txt")
//get the input file as an array into program
var program = input.components(separatedBy: ",").compactMap { Int($0) }
print("Prog: \(program)")
var index = 0

// the index will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
while program[index] != 99 {
//for i in 0..<2 {
    let instruction = createInstruction(program: program , index: index)
    print("instruction: \(program[index])")
    print("index: \(index)")
    print("Prog: \(program)")
    switch instruction.opcode {
        case .add:
            print("add! got it")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            program[program[index + 3]] = instruction.parameters[0] + instruction.parameters[1]
            print("value: \(instruction.parameters[0]) + \(instruction.parameters[1]) = \(instruction.parameters[0] + instruction.parameters[1]) written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            index += 4
        case .multiply:
            print("multiply ")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            program[program[index + 3]] = instruction.parameters[0] * instruction.parameters[1]
            print("value: \(instruction.parameters[0]) * \(instruction.parameters[1]) = \(instruction.parameters[0] * instruction.parameters[1]) written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            
            index += 4
        case .input:
            print(" TEST Input: 1 ")
            // readLine does not work in Playgrounds 😅 I will hardcode it to 1
            program[program[index + 1]] = 5
            index += 2
        case .output:
            print("output got: \(instruction.parameters[0])")
            index += 2
            print("continue with \(program[index])\n")
        case .jumpIfTrue:
            //Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
            print("jumpIfTrue")
            print( instruction.parameters)
            //print("range: \(program[index...index+2])")
            if instruction.parameters[0] != 0 {
                index = instruction.parameters[1]
                print("jump to \(program[index])\n")
                } else {
                index += 3
                print("continue with \(program[index])\n")
            }
            
        case .jumpIfFalse:
            //Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
            print("jumpIfFalse")
            print( instruction.parameters)
            //print("range: \(program[index...index+2])")
            if instruction.parameters[0] == 0 {
                index = instruction.parameters[1]
                print("jump to \(program[index])\n")
                continue
                } else {
                index += 3
                print("continue with \(program[index])\n")
            }
            
        case .lessThan:
            //Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
            print("lessThan")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            if instruction.parameters[0] < instruction.parameters[1] {
                program[program[index + 3]] = 1 } else {
                program[program[index + 3]] = 0
            }
            print("value: if \(instruction.parameters[0]) < \(instruction.parameters[1]) then 1 written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            index += 4
        case  .equals:
            print("equals")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            if instruction.parameters[0] == instruction.parameters[1] {
                program[program[index + 3]] = 1 } else {
                program[program[index + 3]] = 0
            }
            print("value: if \(instruction.parameters[0]) = \(instruction.parameters[1]) then 1 written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            index += 4
        case .halt:
            print("stop")
        
   }
}
print("stop")

// solution 6761139
