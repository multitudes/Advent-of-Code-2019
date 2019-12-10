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

/**
 Generates all possible permutations of `data` using Heap's Algorithm
 - parameters:
   - data: The data to permute
   - output: A closure called with each permutation of the data
 */


var phases = [0,1,2,3,4] // This can be any array
var phaseSettings = [[Int]]()
// phasePermutation is in the util functions
phasePermutation(phases: &phases) { result in phaseSettings.append(result) }
print(phaseSettings)

