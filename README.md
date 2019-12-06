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
| ✔ [Day 1: The Tyranny of the Rocket Equation](https://github.com/multitudes/Advent-of-Code-2019#Day-1-The-Tyranny-of-the-Rocket-Equation)|⭐️|⭐️|
|   [Day 2: 1202 Program Alarm](https://adventofcode.com/2019/day/2)| | |



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

//a little bit of functional programming. the filter() method creates a new array from an existing one, selecting from it only items that match a function you provide
moduleMasses = moduleMasses.filter { $0 != "" }

// recursive function to get the total fuel
func calculateFuel(fuel: Int) -> Int {
    if fuel <= 0 { return 0 }
    return fuel + calculateFuel(fuel: fuel / 3 - 2)
}

// compactMap transform the elements of an array just like map() does, except once the transformation completes an extra step happens: all optionals get unwrapped, and any nil values get discarded.

// some functional programming
var fuel = moduleMasses.compactMap { Int($0) }.map {  (fuel: Int) -> Int in
                                                    let fuelmass = fuel / 3 - 2
                                                    return  calculateFuel(fuel: fuelmass)}

//Reduce allows us to extract one single value from a sequence, by performing a series of operations in the sequence’s elements.
let totalFuel = fuel.reduce(0, +)

print("The answer is : \(totalFuel)")

// The answer is : 4728317
```

If you hit problems or have questions, you're welcome to tweet me [@wrmultitudes](https://twitter.com/wrmultitudes) .

