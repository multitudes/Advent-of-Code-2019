//: [Previous](@previous)
/*:
# Day 11: Space Police

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
On the way to Jupiter, you're pulled over by the Space Police.

"Attention, unmarked spacecraft! You are in violation of Space Law! All spacecraft must have a clearly visible registration identifier! You have 24 hours to comply or be sent to Space Jail!"

Not wanting to be sent to Space Jail, you radio back to the Elves on Earth for help. Although it takes almost three hours for their reply signal to reach you, they send instructions for how to power up the emergency hull painting robot and even provide a small Intcode program (your puzzle input) that will cause it to paint your ship appropriately.

There's just one problem: you don't have an emergency hull painting robot.
 [...]
 Build a new emergency hull painting robot and run the Intcode program on it. How many panels does it paint at least once?
 
 
: [Next](@next)
*/

import Foundation


var robot = Robot(inputFile: "input11")
robot.runProgram()
print(robot.paintedSquares.count)

