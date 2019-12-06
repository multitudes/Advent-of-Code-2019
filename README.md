# Advent of Code 2019 for Swift

Advent of Code 2019 ✨🚀 Swift Solutions by 
`@multitudes` 
[Blog](https://multitudes.github.io)
|
[Twitter](https://twitter.com/wrmultitudes)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


## What is Advent of Code?
[Advent of Code](http://adventofcode.com) is an online event created by [Eric Wastl](https://twitter.com/ericwastl). Each year an advent calendar of small programming puzzles is unlocked once a day, they can be solved in any programming language you like. 

## Advent of Code 2019 Story
Santa has become stranded at the edge of the Solar System while delivering presents to other planets! To accurately calculate his position in space, safely align his warp drive, and return to Earth in time to save Christmas, he needs you to bring him measurements from fifty stars.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

The Elves quickly load you into a spacecraft and prepare to launch.

## Progress
| Day  | Part One | Part Two | 
|---|:---:|:---:|
| ✔ [Day 1: The Tyranny of the Rocket Equation](https://github.com/multitudes/Advent-of-Code-2019#Day-1-The-Tyranny-of-the-Rocket-Equation)|✅ ||
| ✔ [Day 2: 1202 Program Alarm]()| | |
| ✔ [Day 3: Crossed Wires]()| | |


## Day 1: The Tyranny of the Rocket Equation

Santa has become stranded at the edge of the Solar System while delivering presents to other planets! To accurately calculate his position in space, safely align his warp drive, and return to Earth in time to save Christmas, he needs you to bring him measurements from fifty stars.
Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
The Elves quickly load you into a spacecraft and prepare to launch.
At the first Go / No Go poll, every Elf is Go until the Fuel Counter-Upper. They haven't determined the amount of fuel required yet.
Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.
For example:
For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
For a mass of 1969, the fuel required is 654.
For a mass of 100756, the fuel required is 33583.
The Fuel Counter-Upper needs to know the total fuel requirement. To find it, individually calculate the fuel needed for the mass of each module (your puzzle input), then add together all the fuel values.

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



If you hit problems or have questions, you're welcome to tweet me [@wrmultitudes](https://twitter.com/wrmultitudes) .

