//: [Previous](@previous)
/*:
# Day 13: Care Package

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
As you ponder the solitude of space and the ever-increasing three-hour roundtrip for messages between you and Earth, you notice that the Space Mail Indicator Light is blinking. To help keep you sane, the Elves have sent you a care package.

It's a new game for the ship's arcade cabinet! Unfortunately, the arcade is all the way on the other end of the ship. Surely, it won't be hard to build your own - the care package even comes with schematics.

The arcade cabinet runs Intcode software like the game the Elves sent (your puzzle input). It has a primitive screen capable of drawing square tiles on a grid. The software draws tiles to the screen with output instructions: every three output instructions specify the x position (distance from the left), y position (distance from the top), and tile id. The tile id is interpreted as follows:

0 is an empty tile. No game object appears in this tile.
1 is a wall tile. Walls are indestructible barriers.
2 is a block tile. Blocks can be broken by the ball.
3 is a horizontal paddle tile. The paddle is indestructible.
4 is a ball tile. The ball moves diagonally and bounces off objects.
For example, a sequence of output values like 1,2,3,6,5,4 would draw a horizontal paddle tile (1 tile from the left and 2 tiles from the top) and a ball tile (6 tiles from the left and 5 tiles from the top).

Start the game. How many block tiles are on the screen when the game exits?
 
 
: [Next](@next)
*/

import Foundation

// func getInput is in utilities file
var input = getInput(inputFile: "input13", extension: "txt")
//get the input file as an array into program
var inputProgramArray = input.components(separatedBy: ",").compactMap { Int($0) }
//print(inputProgramArray)
var progrLength = inputProgramArray.count
//print("length : \(progrLength)")
// when I load my program in memory it becomes a dict!
var program = Dictionary(uniqueKeysWithValues: zip(0..., inputProgramArray))



var index = 0
print(index)
var relativeBase = 0
var outputs = [Int]()
outputs = []
// the index will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
//while outputs.count != 1 {
    print(outputs)
    outputs = []
    index = 0
while program[index] != 99 {

    //print(program)
    if index <= 0 { index = 0 }
    // just in case initialize some memory here
    for i in 0..<4 {
        if program[index + i] == nil { program[index + i] == 0 }
    }
    print("instr range: \(program[index] ?? 0) - \(program[index+1] ?? 0) - \(program[index+2] ?? 0) - \(program[index+3] ?? 0)")
    print("index: \(index)")
    print("relativeBase: \(relativeBase)")
    //print("Prog: \(program)")
    
    if program[index]! / 10000 > 3 {
        print("\n error opcode =================\n ")
        break
    }
    // func createInstruction is in utilities file and returns an instance of the Instruction struct
    let instruction = createInstruction(program: program , index: index, relativeBase: relativeBase)
    switch instruction.opcode {
        case .add:
            print("\nadd! got it")
            print("parameters: \(instruction.parameters)")
            program[instruction.parameters[2]] = instruction.parameters[0] + instruction.parameters[1]
            print("value: \(instruction.parameters[0]) + \(instruction.parameters[1]) = \(instruction.parameters[0] + instruction.parameters[1]) written to \(instruction.parameters[2])")
            print("is this right ? \(program[instruction.parameters[2]]!)\n")
            index += 4
        case .multiply:
            print("multiply ")
            print( instruction.parameters)
            program[instruction.parameters[2]] = instruction.parameters[0] * instruction.parameters[1]
            print("value: \(instruction.parameters[0]) * \(instruction.parameters[1]) = \(instruction.parameters[0] * instruction.parameters[1]) written to \(instruction.parameters[2])")
            print("is this right ? \(program[instruction.parameters[2]]!)\n")
            index += 4
        case .input:
            print("\n TEST Input: 2 ")
            // readLine does not work in Playgrounds 😅 I will hardcode it
            program[instruction.parameters[0]] = 2
            index += 2
        case .output:
            print("output got: \(instruction.parameters[0])")
            index += 2
            outputs.append(instruction.parameters[0])
            print("continue with \(program[index]!)\n")
        case .jumpIfTrue:
            //Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
            print("jumpIfTrue")
            print( instruction.parameters)
            //print("range: \(program[index...index+2])")
            if instruction.parameters[0] != 0 {
                index = instruction.parameters[1]
                print("jump to index \(index)\n")
                } else {
                index += 3
                print("continue with \(program[index]!)\n")
            }
            
        case .jumpIfFalse:
            //Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
            print("jumpIfFalse")
            print( instruction.parameters)
            //print("range: \(program[index...index+2])")
            if instruction.parameters[0] == 0 {
                index = instruction.parameters[1]
                print("jump to \(program[index]!)\n")
                continue
                } else {
                index += 3
                print("continue with \(program[index]!)\n")
            }
            
        case .lessThan:
            //Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
            print("lessThan")
            print( instruction.parameters)
            if instruction.parameters[0] < instruction.parameters[1] {
                program[instruction.parameters[2]] = 1 } else {
                program[instruction.parameters[2]] = 0
            }
            print("value: if \(instruction.parameters[0]) < \(instruction.parameters[1]) then 1 written to \(instruction.parameters[2])")
            print("is this right ? \(program[instruction.parameters[2]]!)\n")
            index += 4
        
        case  .equals:
            print("equals")
            print( instruction.parameters)
            if instruction.parameters[0] == instruction.parameters[1] {
                program[instruction.parameters[2]] = 1 } else {
                program[instruction.parameters[2]] = 0
            }
            print("value: if \(instruction.parameters[0]) = \(instruction.parameters[1]) then 1 written to \(instruction.parameters[2])")
            print("is this right ? \(program[instruction.parameters[2]]!)\n")
            index += 4
        case .relativeBaseOffset:
            print("relativeBaseOffset")
            print( instruction.parameters)
            relativeBase += instruction.parameters[0]
            print("relativeBase is now  = \(relativeBase)\n")
            index += 2
        case .halt:
            print("stop")
        
   }
}
print("stop\n ---------------------------------------------- \n -------------------------------------------------- \n")
    //print(program)
print("Outputs \(outputs)")
//}

