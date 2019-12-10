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
//phasePermutation(phases: &phases) { result in phaseSettings.append(result) }
//print(phaseSettings) // now an array of phases [[0, 1, 2, 3, 4], [1, 0, 2, 3, 4], [2, 0, 1, 3, 4]]
phasePermutation(phases: &phasesFeedback) { result in phaseSettingsFeedback.append(result) } // for part 2
// func getInput is in utilities file
var input = getInput(inputFile: "input7", extension: "txt")
//print(input)
//get the input file as an array into program
var program = input.components(separatedBy: ",").compactMap { Int($0) }
print(program)


    let maxSignal2: Int = phaseSettingsFeedback.map { combo in
        var amplifiers = combo.map { Computer(program: program, inputs: [$0]) }
        var nextInput = 0 // starting input
        // while no amplifers are halted, continually loop over all amplifiers,
        // passing the last output we've seen in as the next input
        while !amplifiers.contains { $0.isHalted } {
            for i in 0...4 {
                amplifiers[i].inputs.append(nextInput)
                if let next = amplifiers[i].runProgramUntilNextOutput() {
                    nextInput = next
                } else {
                    // an amplifer halted; we are done
                    break
                }
            }
        }
        return nextInput
    }.max()!

    print("Part 2: \(maxSignal2)")

