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
// declare empty array
var phaseSettingsFeedback = [[Int]]() // this is for part 2
// phasePermutation is in the util functions
phasePermutation(phases: &phasesFeedback) { result in phaseSettingsFeedback.append(result) } // for part 2
// func getInput is in utilities file
var input = getInput(inputFile: "input7", extension: "txt")
//get the input file as an array into program
var program = input.components(separatedBy: ",").compactMap { Int($0) }
// for each array in phaseSettingsFeedback I get a variable phases like [9,8,7,6,5]
let amplifiedOutput: Int = phaseSettingsFeedback.map { phases in
    // computed property inside closure. Phases again map. for every value I create a Computer running his own version of the program
    // taking one phase each as input 9, 8, 7, 6, 5
    var amplifiers = phases.map {
        Computer(program: program, inputs: [$0])
        }
    // start
    var input = 0
    // loop over the amplifiers until one of them  gets to opcode 99
    while !amplifiers.contains { $0.isHalted } {
        for i in 0...4 {
            // for amplifier 0 the input will be 0
            amplifiers[i].inputs.append(input)
            // after the first amplifier input will be the output of the previous
            if let output = amplifiers[i].runProgramUntilNextOutput() {
                input = output
            } else {
                break
            }
            
        } // after finishing the for loop 0...4 I start again.. the output will go to the input of the first amp
    }
    // this is the last output when one of the amps did halt
    return input
// the closure ends here. each result has been mapped and I take the max
}.max()!

print("Solution Part 2: \(amplifiedOutput)")

