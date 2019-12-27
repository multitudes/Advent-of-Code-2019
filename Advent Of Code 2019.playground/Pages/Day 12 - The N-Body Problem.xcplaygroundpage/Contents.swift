//: [Previous](@previous)
/*:
# Day 12: The N-Body Problem

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
The space near Jupiter is not a very safe place; you need to be careful of a big distracting red spot, extreme radiation, and a whole lot of moons swirling around. You decide to start by tracking the four largest moons: Io, Europa, Ganymede, and Callisto.

After a brief scan, you calculate the position of each moon (your puzzle input). You just need to simulate their motion so you can avoid them.

Each moon has a 3-dimensional position (x, y, and z) and a 3-dimensional velocity. The position of each moon is given in your scan; the x, y, and z velocity of each moon starts at 0.

Simulate the motion of the moons in time steps. Within each time step, first update the velocity of every moon by applying gravity. Then, once all moons' velocities have been updated, update the position of every moon by applying velocity. Time progresses by one step once all of the positions are updated.

To apply gravity, consider every pair of moons. On each axis (x, y, and z), the velocity of each moon changes by exactly +1 or -1 to pull the moons together. For example, if Ganymede has an x position of 3, and Callisto has a x position of 5, then Ganymede's x velocity changes by +1 (because 5 > 3) and Callisto's x velocity changes by -1 (because 3  `<` 5). However, if the positions on a given axis are the same, the velocity on that axis does not change for that pair of moons.

Once all gravity has been applied, apply velocity: simply add the velocity of each moon to its own position. For example, if Europa has a position of x=1, y=2, z=3 and a velocity of x=-2, y=0,z=3, then its new position would be x=-1, y=2, z=6. This process does not modify the velocity of any moon.

What is the total energy in the system after simulating the moons given in your scan for 1000 steps?
 
 
: [Next](@next)
*/

import Foundation

// Regex in Swift have a slightly clumsy syntax thanks to their Objective-C roots.
// This is my input file
var input = getInput(inputFile: "input12", extension: "txt")
// to replace or remove text in a string in swift I could use replacingOccurrences(of:, with:) but in this case Regex is better, however certainly somewhat cumbersome. Not so nice like in python though
let regex = try! NSRegularExpression(pattern: "[<=xyz\n]")
let range = NSRange(input.startIndex..., in: input)
var moons = regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: "").split(separator: ">").map{ String($0).split(separator: ",").compactMap { NumberFormatter().number(from: String($0))?.intValue }}
//print(moons)


// Part one!
// debug
//var jupyter = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
//jupyter.runNumberOf(steps: 10)

// this is for input12b result 1940
//var jupyter2 = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
//jupyter2.runNumberOf(steps: 100)

var jupyter = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
// solution part one is outup of this function
jupyter.runNumberOf(steps: 1000)

//part 2
// this solution still take too long howeveer :(
// will need to optimize this again. Not optimal!
// for every axis I calculate the number of steps to get to the initial state. In this challenge the axis are indipendent so i do not need to get the initial state of all three axis x, y , z at the same time. Just one at the time and then the total number of steps for the three axis to be in the initial state will be the lowest common multiplier!
// the lcm algo is in the sources folder. I made a new step per dimension method for part two. paramether is axis x is 0 y is 1 and z is 2
let a = jupyter.stepPerDimension(axis: 0)
let b = jupyter.stepPerDimension(axis: 1)
let c = jupyter.stepPerDimension(axis: 2)
let solutionPart2 = lcm(a,b,c)

print("\n\nPart two solution! Total number of steps is \(solutionPart2)\n")
