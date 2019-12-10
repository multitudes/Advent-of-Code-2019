//: [Previous](@previous)
/*:
# Day 7: Amplification Circuit

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
Based on the navigational maps, you're going to need to send more power to your ship's thrusters to reach Santa in time. To do this, you'll need to configure a series of amplifiers already installed on the ship.

There are five amplifiers connected in series; each one receives an input signal and produces an output signal. They are connected such that the first amplifier's output leads to the second amplifier's input, the second amplifier's output leads to the third amplifier's input, and so on. The first amplifier's input value is 0, and the last amplifier's output leads to your ship's thrusters.

The Elves have sent you some Amplifier Controller Software (your puzzle input), a program that should run on your existing Intcode computer. Each amplifier will need to run a copy of the program.

 [...]
 
 Try every combination of phase settings on the amplifiers. What is the highest signal that can be sent to the thrusters?
 
: [Next](@next)
*/
import Foundation

var phases = [0,1,2,3,4] // This can be any array
var phasesFeedback = [9,8,7,6,5] // this is for part 2
var phaseSettings = [[Int]]()
var phaseSettingsFeedback = [[Int]]() // this is for part 2

// phasePermutation is in the util functions
phasePermutation(phases: &phases) { result in phaseSettings.append(result) }
//print(phaseSettings) // now an array of phases [[0, 1, 2, 3, 4], [1, 0, 2, 3, 4], [2, 0, 1, 3, 4]]
phasePermutation(phases: &phases) { result in phaseSettingsFeedback.append(result) } // for part 2
// func getInput is in utilities file
var input = getInput(inputFile: "input7", extension: "txt")
//print(input)
//get the input file as an array into program
var program = input.components(separatedBy: ",").compactMap { Int($0) }
print(program)


// part 1
  
   let amplifiedOutput: Int = phaseSettings.map { combo in
       var nextInput = 0
       for i in 0...4 {
           var computer = Computer(program: program, inputs: [combo[i], nextInput])
           computer.runProgramUntilComplete()
           nextInput = computer.takeOutput()
       }
       return nextInput
   }.max()!

   print("Solution Part 1: \(amplifiedOutput)")


// this used to work.. now that I finished day 7 part two the part 1 doesnt work anymore,.. doing a refoactoring!

//func amplifier(originalProgram: [Int], phases: [Int]) -> Int {
//    // output
//    var output = 0
//
//    for i in 0..<5 {
//        var index = 0
//        var program = originalProgram
//        // swift does not let me input values in the playgrounds so this needs to be hardcoded
//        var inputindex = 0
//
//        // the index will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
//        while program[index] != 99 {
//        //for i in 0..<2 {
//            // func createInstruction is in utilities file and returns an instance of the Instruction struct
//            let instruction = createInstruction(program: program , index: index)
//            print("instruction: \(program[index])")
//            print("index: \(index)")
//            print("Prog: \(program)")
//            switch instruction.opcode {
//                case .add:
//                    print("add! got it")
//                    print( instruction.parameters)
//                    print("range: \(program[index...index+3])")
//                    program[program[index + 3]] = instruction.parameters[0] + instruction.parameters[1]
//                    print("value: \(instruction.parameters[0]) + \(instruction.parameters[1]) = \(instruction.parameters[0] + instruction.parameters[1]) written to \(program[index + 3])")
//                    print("is this right ? \(program[program[index + 3]])\n")
//                    index += 4
//                case .multiply:
//                    print("multiply ")
//                    print( instruction.parameters)
//                    print("range: \(program[index...index+3])")
//                    program[program[index + 3]] = instruction.parameters[0] * instruction.parameters[1]
//                    print("value: \(instruction.parameters[0]) * \(instruction.parameters[1]) = \(instruction.parameters[0] * instruction.parameters[1]) written to \(program[index + 3])")
//                    print("is this right ? \(program[program[index + 3]])\n")
//
//                    index += 4
//                case .input:
//                    // readLine does not work in Playgrounds 😅 I will hardcode it
//                    if inputindex == 0 {
//                        print(" TEST Input: index\(inputindex) value: \(phases[i]) ")
//                        program[program[index + 1]] = phases[i]
//                    } else if inputindex == 1 {
//                        print(" TEST Input: index\(inputindex) value: \(output) ")
//                        program[program[index + 1]] = output
//                    }
//                    inputindex += 1
//                    if inputindex > 2 { print("\n------error-----\n")}
//                    index += 2
//                case .output:
//                    print("output got: \(instruction.parameters[0]) ------------")
//                    // this will take only the last value of the output
//                    output = instruction.parameters[0]
//                    index += 2
//                    print("new output got: \(output) ------------")
//                    print("continue with \(program[index])\n")
//                case .jumpIfTrue:
//                    //Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
//                    print("jumpIfTrue")
//                    print( instruction.parameters)
//                    //print("range: \(program[index...index+2])")
//                    if instruction.parameters[0] != 0 {
//                        index = instruction.parameters[1]
//                        print("jump to \(program[index])\n")
//                        } else {
//                        index += 3
//                        print("continue with \(program[index])\n")
//                    }
//
//                case .jumpIfFalse:
//                    //Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
//                    print("jumpIfFalse")
//                    print( instruction.parameters)
//                    //print("range: \(program[index...index+2])")
//                    if instruction.parameters[0] == 0 {
//                        index = instruction.parameters[1]
//                        print("jump to \(program[index])\n")
//                        continue
//                        } else {
//                        index += 3
//                        print("continue with \(program[index])\n")
//                    }
//
//                case .lessThan:
//                    //Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
//                    print("lessThan")
//                    print( instruction.parameters)
//                    print("range: \(program[index...index+3])")
//                    if instruction.parameters[0] < instruction.parameters[1] {
//                        program[program[index + 3]] = 1 } else {
//                        program[program[index + 3]] = 0
//                    }
//                    print("value: if \(instruction.parameters[0]) < \(instruction.parameters[1]) then 1 written to \(program[index + 3])")
//                    print("is this right ? \(program[program[index + 3]])\n")
//                    index += 4
//                case  .equals:
//                    print("equals")
//                    print( instruction.parameters)
//                    print("range: \(program[index...index+3])")
//                    if instruction.parameters[0] == instruction.parameters[1] {
//                        program[program[index + 3]] = 1 } else {
//                        program[program[index + 3]] = 0
//                    }
//                    print("value: if \(instruction.parameters[0]) = \(instruction.parameters[1]) then 1 written to \(program[index + 3])")
//                    print("is this right ? \(program[program[index + 3]])\n")
//                    index += 4
//                case .halt:
//                    print("stop")
//
//            }
//        }
//    print("stop \(i)")
//
//
//    }
//    return output
//}
//
// test with input7a.txt gives 43210
// test with input7b.txt gives 54321 and 7c
//let amplifiedOutput = phaseSettings.map { amplifier(originalProgram: program, phases: $0) }.max()!
//
//
//
