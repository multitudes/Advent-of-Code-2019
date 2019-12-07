# Advent of Code 2019 for Xcode Swift Playgrounds

Advent of Code 2019 ✨🚀 Swift Solutions by 
`@multitudes` 
[Blog](https://multitudes.github.io)
|
[Twitter](https://twitter.com/wrmultitudes)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

This is a collection of self contained Swift Playgrounds with the solutions to the advent of code quizzes. 

## What is Advent of Code?
[Advent of Code](http://adventofcode.com) is an online event created by [Eric Wastl](https://twitter.com/ericwastl). Each year an advent calendar of small programming puzzles is unlocked once a day, they can be solved in any programming language you like. 

## Advent of Code 2019 Story
Santa has become stranded at the edge of the Solar System while delivering presents to other planets! To accurately calculate his position in space, safely align his warp drive, and return to Earth in time to save Christmas, he needs you to bring him measurements from fifty stars.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

The Elves quickly load you into a spacecraft and prepare to launch.

## Progress
| Day  | Part One | Part Two | 
|---|:---:|:---:|
| ✔ [Day 1: The Tyranny of the Rocket Equation](https://github.com/multitudes/Advent-of-Code-2019#Day-1-The-Tyranny-of-the-Rocket-Equation)|⭐️|⭐️|
| ✔ [Day 2: 1202 Program Alarm](https://github.com/multitudes/Advent-of-Code-2019#Day-2-1202-Program-Alarm)|⭐️|⭐️ |
| ✔ [Day 3: Crossed Wires](https://github.com/multitudes/Advent-of-Code-2019#Day-3-Crossed-Wires)| | |


## [Day 1: The Tyranny of the Rocket Equation](https://adventofcode.com/2019/day/1)

The Elves quickly load you into a spacecraft and prepare to launch.
At the first Go / No Go poll, every Elf is Go until the Fuel Counter-Upper. They haven't determined the amount of fuel required yet. [...]
Fuel required to launch a given module is based on its mass.

What is the sum of the fuel requirements for all of the modules on your spacecraft?

```swift

    import UIKit

    // declaring the var containing the input
    var input = ""

    // this will look in my resources folder for the input.txt file
    do {
        guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
        input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
        print(input)
    } catch {
        print(error)
    }

    //get the input file as an array into moduleMass
    var moduleMasses = input.components(separatedBy: "\n")
    print(moduleMasses)

    //a little bit of functional programming. the filter() method creates a new array from an existing one, selecting from it only items that match a function you provide
    moduleMasses = moduleMasses.filter { $0 != "" }
    // and compactMap transform the elements of an array just like map() does, except once the transformation completes an extra step happens: all optionals get unwrapped, and any nil values get discarded.

    var fuel = moduleMasses.compactMap { Int($0) }.map { $0 / 3 - 2}
    print(fuel)

    //Reduce allows us to extract one single value from a sequence, by performing a series of operations in the sequence’s elements.
    let totalFuel = fuel.reduce(0, +)

    print("The answer is : \(totalFuel)")
```

###            --- Part Two ---

During the second Go / No Go poll, the Elf in charge of the Rocket Equation Double-Checker stops the launch sequence. Apparently, you forgot to include additional fuel for the fuel you just added.
Fuel itself requires fuel just like a module - take its mass, divide by three, round down, and subtract 2. However, that fuel also requires fuel, and that fuel requires fuel, and so on. [...]

```swift
import UIKit

// declaring the var containing the input
var input = ""

// this will look in my resources folder for the input.txt file which is still the same
do {
    guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
    input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
} catch {
    print(error)
}

//get the input file as an array into moduleMass
var moduleMasses = input.components(separatedBy: "\n")

// recursive function to get the total fuel
func calculateFuel(fuel: Int) -> Int {
    if fuel <= 0 { return 0 }
    return fuel + calculateFuel(fuel: fuel / 3 - 2)
}

//a little bit of functional programming. the filter() method creates a new array from an existing one, selecting from it only items that match a function you provide
moduleMasses = moduleMasses.filter { $0 != "" }

// and compactMap transform the elements of an array just like map() does, except once the transformation completes an extra step happens: all optionals get unwrapped, and any nil values get discarded.
var fuel = moduleMasses.compactMap { Int($0) }.map {  (fuel: Int) -> Int in
                                                    let fuelmass = fuel / 3 - 2
                                                    return  calculateFuel(fuel: fuelmass)}

//Reduce allows us to extract one single value from a sequence, by performing a series of operations in the sequence’s elements.
let totalFuel = fuel.reduce(0, +)

print("The answer is : \(totalFuel)")

// The answer is : 4728317

```

## [Day 2: 1202 Program Alarm](https://adventofcode.com/2019/day/2)

On the way to your gravity assist around the Moon, your ship computer beeps angrily about a "1202 program alarm"...

```swift

import UIKit

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

//get the input file as an array into moduleMass
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
```

###            --- Part Two ---

Good, the new computer seems to be working correctly! Keep it nearby during this mission - you'll probably use it again...
The inputs should still be provided to the program by replacing the values at addresses 1 and 2, just like before. In this program, the value placed in address 1 is called the noun, and the value placed in address 2 is called the verb. Each of the two input values will be between 0 and 99, inclusive.
Once the program has halted, its output is available at address 0, also just like before. Each time you try a pair of inputs, make sure you first reset the computer's memory to the values in the program (your puzzle input) - in other words, don't reuse memory from a previous attempt.
Find the input noun and verb that cause the program to produce the output 19690720. 
What is 100 * noun + verb? (For example, if noun=12 and verb=2, the answer would be 1202.)


```swift
import UIKit

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

//get the input file as an array into moduleMass
var origProgram = input.components(separatedBy: ",").compactMap { Int($0) }

var solution = 0

outerLoop: for noun in 0...99 {
    for verb in 0...99 {
// reset. This works because arrays are structs in swift and passed as value not reference!
var program = origProgram

//before running the program, replace position 1 with the value noun and replace position 2 with the value verb.
program[1] = noun
program[2] = verb

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
        if program[0] == 19690720 {
            solution = 100 * noun + verb
            break outerLoop
        }
    }
}

print("the solution is : \(solution)")

//the solution is : 5121
```
## [Day 3: Crossed Wires](https://adventofcode.com/2019/day/3)

Opening the front panel reveals a jumble of wires. Specifically, two wires are connected to a central port and extend outward on a grid. You trace the path each wire takes as it leaves the central port, one wire per line of text (your puzzle input).What is the Manhattan distance from the central port to the closest intersection?
If you hit problems or have questions, you're welcome to tweet me [@wrmultitudes](https://twitter.com/wrmultitudes) .

###            --- Part Two ---
