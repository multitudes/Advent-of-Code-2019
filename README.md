# Advent of Code 2019 for Xcode Swift Playgrounds

Advent of Code 2019 ✨🚀 Swift Solutions by 
`@multitudes` 
[Blog](https://multitudes.github.io)
|
[Twitter](https://twitter.com/wrmultitudes)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

This is a collection of self contained Swift Playgrounds with the solutions to the advent of code quizzes.
The code below will be missing some parts which have been refactored in utility files. The playground file however includes everything. Please download the playground and run on a mac in Xcode. It is divided into days and easy to paginate through.

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
| ✔ [Day 3: Crossed Wires](https://github.com/multitudes/Advent-of-Code-2019#Day-3-Crossed-Wires)|⭐️|⭐️|
| ✔ [Day 4: Secure Container](https://github.com/multitudes/Advent-of-Code-2019#Day-4-Secure-Container)|⭐️|⭐️|
| ✔ [Day 5: Sunny with a Chance of Asteroids](https://github.com/multitudes/Advent-of-Code-2019#Day-5-Sunny-with-a-Chance-of-Asteroids)|⭐️|⭐️|
| ✔ [Day 6: Universal Orbit Map](https://github.com/multitudes/Advent-of-Code-2019#Day-6-Universal-Orbit-Map)|⭐️|⭐️|
| ✔ [Day 7: Amplification Circuit](https://github.com/multitudes/Advent-of-Code-2019#Day-7-Amplification-Circuit)|⭐️|⭐️|
| ✔ [Day 8: Space Image Format](https://github.com/multitudes/Advent-of-Code-2019#Day-8-Space-Image-Format)|⭐️|⭐️|
| ✔ [Day 9: Sensor Boost](https://github.com/multitudes/Advent-of-Code-2019#Day-9-Sensor-Boost)|⭐️|⭐️|
| ✔ [Day 10: Monitoring Station](https://github.com/multitudes/Advent-of-Code-2019#Day-10-Monitoring-Station)|⭐️|⭐️|
| ✔ [Day 11: Space Police](https://github.com/multitudes/Advent-of-Code-2019#Day-11-Space-Police)|⭐️|⭐️|
| ✔ [Day 12: The N-Body Problem](https://github.com/multitudes/Advent-of-Code-2019#Day-12-The-N-Body-Problem)|⭐️|⭐️|
| ✔ [Day 13: Care Package](https://github.com/multitudes/Advent-of-Code-2019#Day-13-Care-Package)|⭐️||


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


//           --- Part Two ---


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

//            --- Part Two ---

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

```
## [Day 3: Crossed Wires](https://adventofcode.com/2019/day/3)

Opening the front panel reveals a jumble of wires. Specifically, two wires are connected to a central port and extend outward on a grid. You trace the path each wire takes as it leaves the central port, one wire per line of text (your puzzle input).What is the Manhattan distance from the central port to the closest intersection?

```swift
import UIKit

// declaring the var containing the input
var input = ""
// I want to convert the input from an array of strings to an array of tuples: ("L", 627), ("U", 273), ("R", 226),..
var redWire: [(String, Int)]
var blueWire: [(String, Int)]

// this will look in my resources folder for the input.txt file
do {
    guard let fileUrl = Bundle.main.url(forResource: "input3", withExtension: "txt") else { fatalError() }
    input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
    //print("input is: \(input)")
} catch {
    print(error)
}
//get the input file as wire which is two arrays of Strings
var wires = input.components(separatedBy: "\n")
// declare wireTuples as two array of tuples
var wireTuples: [[(String, Int)]] = [[("",0)],[("",0)]]
// loop twice because wires is the input split in two chunks wires[0] and wires[1]
//wiretuple also will be in two chunks wireTuple[0] and wireTuple[1] which will be each an array of tuples
// and assigned to redWire and blueWire
for i in 0..<2 {
    let wire = wires[i].components(separatedBy: ",") // get two arrays of [String] like ["D323",...]
    // get two arrays of tuples, from string. Need to get the first character out and keep the rest as int. Swift is a bit special for strings!
    wireTuples[i] = wire.map {  (str: String) -> (String, Int) in
                            let firstIndex = str.startIndex
                            let a = str[firstIndex]
                            let secondIndex = str.index(after: str.startIndex)
                            let lastIndex = str.endIndex
                            let range = secondIndex..<lastIndex
                            let b = Int(str[range])
                            return  (String(a), b ?? 0)}
                            }
}
// got my two wires - the tuples are like ("U", 732), ("L", 444)
redWire = wireTuples[0]
blueWire = wireTuples[1]

// From each Tuple in redWire and BlueWire I create arrays of points containing all the coordinates of every point on the lines
// and will see where they cross
// initialise the array of coordinates - coordinates are x and y values in a struct called Point declared in sources folder
var redPath:[Point] = []
var bluePath:[Point] = []

// fill the coordinates array from the instructions in the wireTuples array - function drawpath is in the playground included in the sources folder. Arrays are struct and passed by value in Swift so I need to pass by reference
drawPath(path: &redPath, wire: redWire)
drawPath(path: &bluePath, wire: blueWire)
// convert the array to set and get the intersection. Set is better that using contains() for large data
let commonElements = Array(Set(bluePath).intersection(Set(redPath)))
// The manhattan distance is the sum of the abs of coordinates. I look for the smallest
let manhattan = commonElements.compactMap { abs($0.x) + abs($0.y) }.min()
print("the answer is : \(manhattan!)")

//            --- Part Two ---
// till here same as part 1.. then add steps as a dictionary storing point and the steps done to get there! 

var redPath:[Point] = []
var bluePath:[Point] = []
var steps = [Point: Int]()
 
// fill the coordinates array with the instructions in the wire array - function drawpath is in the playground included
// in the sources folder. Arrays are struct and passed by value in Swift so I need to pass by reference
drawPath(path: &redPath, wire: redWire)
drawPath(path: &bluePath, wire: blueWire)
// convert the array to set and get the intersection
let commonElements = Array(Set(bluePath).intersection(Set(redPath)))
//I create two dictionaries for both wires
var blueSteps = [Point: Int]()
var redSteps = [Point: Int]()

 // I loop over the commonElements putting the index of redPath and bluePath as value for the points found to intersect
commonElements.forEach {
    blueSteps[$0] = bluePath.firstIndex(of: $0)
    redSteps[$0] = redPath.firstIndex(of: $0)
    // this is a dic which for every point in the intersection will store the sum of the steps of both wires
    steps[$0] = blueSteps[$0]! + redSteps[$0]!
 }
// just need to find the min value of the dictionary
let fewestSteps = steps.min { $0.value < $1.value }
// solution is plus two because I start counting steps for both redPath and bluePath from 0 so the counts are already 1 less
// adding both I am two steps short which I add at the end
let solution = fewestSteps!.value + 2
print("the solution is : \(solution)")
```

## [Day 4: Secure Container](https://adventofcode.com/2019/day/4)
You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password on a sticky note, but someone threw it out. [...]
How many different passwords within the range given in your puzzle input meet these criteria?

```swift
import Foundation

// Your puzzle input is 359282-820401.
let input = "359282-820401"

let boundary = input.components(separatedBy: "-")
// safe to force unwrap
let low = Int(boundary[0])!
let high = Int(boundary[1])!
// declare some vars
var flag = false; var double = false
var digits: [Int] = []
var passwords: [Int] = []
// loop over my potential passwords
outerloop: for i in low...high {
    flag = false ; double = false
    digits = i.digits
    for j in 1..<6 {
        if digits[j] == digits[j-1] { double = true }
        if digits[j] >= digits[j-1] { flag = true } else { continue outerloop }
    }
    if double == false { continue outerloop }
    print(digits)
    passwords.append(i)
}
print("Solution of part 1 is \(passwords.count)") 

// starting part 2

var passwordsPart2: [Int] = []
var count = 0
outerloop: for i in 0..<solution1 {
        double = false
        digits = passwords[i].digits
        count = 0
        // I start with the second digit and compare with first in the while
        var j = 1
        while j < 6 {
            while j < 6 && digits[j] == digits[j-1]  {
                count += 1
                // if double is already true then this is a secong double - break - dont need
                if count == 1 && double == true { break }
                // if count is bigger than one then it means it is bigger than a double! keep on looping but double is false
                if count > 1 { double = false } else { double = true }
                j += 1
                }
            // if I am here is because the current digit and previous are different so count is reset in case
            count = 0
            j += 1
            
        }
        if double == false { continue outerloop }
        passwordsPart2.append(passwords[i])
}


let solution2 = passwordsPart2.count
print("Solution of part 2 is \(solution2)")
```
## [Day 5: Sunny with a Chance of Asteroids](https://adventofcode.com/2019/day/5)

You're starting to sweat as the ship makes its way toward Mercury. The Elves suggest that you get the air conditioner working by upgrading your ship computer to support the Thermal Environment Supervision Terminal.

[...]

Finally, the program will output a diagnostic code and immediately halt. This final output isn't an error; an output followed immediately by a halt means the program finished. If all outputs were zero except the diagnostic code, the diagnostic program ran successfully.
After providing 1 to the only input instruction and passing all the tests, what diagnostic code does the program produce?

and part two: 
The air conditioner comes online! Its cold air feels good for a while, but then the TEST alarms start to go off. Since the air conditioner can't vent its heat anywhere but back into the spacecraft, it's actually making the air inside the ship warmer. [...]

Some structs and enums and some func are in a separate file. Download the playgrounds for a full code experience!
The inputs are hardcoded because Xcode playgrounds do not support the readLine() method! 

I had to put a lot of print instructions for the debugging..

```swift

import Foundation

// func getInput is in utilities file
var input = getInput(inputFile: "input5", extension: "txt")
//get the input file as an array into program
var program = input.components(separatedBy: ",").compactMap { Int($0) }
print("Prog: \(program)")
var index = 0

// the index will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
while program[index] != 99 {
//for i in 0..<2 {
    // func createInstruction is in utilities file and returns an instance of the Instruction struct
    let instruction = createInstruction(program: program , index: index)
    print("instruction: \(program[index])")
    print("index: \(index)")
    print("Prog: \(program)")
    switch instruction.opcode {
        case .add:
            print("add! got it")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            program[program[index + 3]] = instruction.parameters[0] + instruction.parameters[1]
            print("value: \(instruction.parameters[0]) + \(instruction.parameters[1]) = \(instruction.parameters[0] + instruction.parameters[1]) written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            index += 4
        case .multiply:
            print("multiply ")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            program[program[index + 3]] = instruction.parameters[0] * instruction.parameters[1]
            print("value: \(instruction.parameters[0]) * \(instruction.parameters[1]) = \(instruction.parameters[0] * instruction.parameters[1]) written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            
            index += 4
        case .input:
            print(" TEST Input: 1 ")
            // readLine does not work in Playgrounds 😅 I will hardcode it to 1
            program[program[index + 1]] = 5
            index += 2
        case .output:
            print("output got: \(instruction.parameters[0])")
            index += 2
            print("continue with \(program[index])\n")
        case .jumpIfTrue:
            //Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
            print("jumpIfTrue")
            print( instruction.parameters)
            //print("range: \(program[index...index+2])")
            if instruction.parameters[0] != 0 {
                index = instruction.parameters[1]
                print("jump to \(program[index])\n")
                } else {
                index += 3
                print("continue with \(program[index])\n")
            }
            
        case .jumpIfFalse:
            //Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
            print("jumpIfFalse")
            print( instruction.parameters)
            //print("range: \(program[index...index+2])")
            if instruction.parameters[0] == 0 {
                index = instruction.parameters[1]
                print("jump to \(program[index])\n")
                continue
                } else {
                index += 3
                print("continue with \(program[index])\n")
            }
            
        case .lessThan:
            //Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
            print("lessThan")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            if instruction.parameters[0] < instruction.parameters[1] {
                program[program[index + 3]] = 1 } else {
                program[program[index + 3]] = 0
            }
            print("value: if \(instruction.parameters[0]) < \(instruction.parameters[1]) then 1 written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            index += 4
        case  .equals:
            print("equals")
            print( instruction.parameters)
            print("range: \(program[index...index+3])")
            if instruction.parameters[0] == instruction.parameters[1] {
                program[program[index + 3]] = 1 } else {
                program[program[index + 3]] = 0
            }
            print("value: if \(instruction.parameters[0]) = \(instruction.parameters[1]) then 1 written to \(program[index + 3])")
            print("is this right ? \(program[program[index + 3]])\n")
            index += 4
        case .halt:
            print("stop")
        
   }
}
print("stop")

```
## [Day 6: Universal Orbit Map](https://adventofcode.com/2019/day/6)

You've landed at the Universal Orbit Map facility on Mercury. Because navigation in space often involves transferring between orbits, the orbit maps here are useful for finding efficient routes between, for example, you and Santa. You download a map of the local orbits (your puzzle input)..
What is the total number of direct and indirect orbits in your map data?

```swift
import Foundation
// func getInput is in utilities file
var input = getInput(inputFile: "input6", extension: "txt")
//get the input file as an array into program
var map = input.components(separatedBy: "\n").filter { $0 != "" }

// class SpaceObject is in separate file. Class contains properties collecting the parent and children of instance

// planet is array of two orbiting bodies like in input a line "H8Y)CGB" gets to planet[0] = "H8Y" and planet[1] is "CGB"
var planets : [String] = []
// create a dictionary. key is the planet I got and the value is the object
var allOrbitingObj = [String : SpaceObject]()

// here I fill all values in my dictionary. I choose a dict because it lets me insert easily new elements checking if they are already there without overwrite them
for i in 0..<map.count {
    // planet will be an array of two planets
    planets = map[i].components(separatedBy: ")")
    // need check if child exists in allOrbitingObj dict, key for the dic is like planet[..] "CGB" and if not create and add it
    // to add to dic need to do dict[key] = val or allOrbitingObj[planet[1]] = objChild creating the objChild on the line before
    if  allOrbitingObj[planets[1]] == nil {
        let objChild = SpaceObject(name: planets[1])
        allOrbitingObj[planets[1]] = objChild
    }
    // check if parent exists and if not create it
    if  allOrbitingObj[planets[0]] == nil {
        let objParent = SpaceObject(name: planets[0])
        allOrbitingObj[planets[0]] = objParent
    }
    // check if parent exists and if so add the child
    if let objParent = allOrbitingObj[planets[0]], let objChild = allOrbitingObj[planets[1]] {
        objParent.add(orbitingObject: objChild)
    }
}

// this recursive function will look for all parents in my objects!
func countParent(planet : SpaceObject) -> Int {
    var count = 0
    if let parent = planet.parentObject {
        count = 1 + countParent(planet: parent)
    }
    return count
}
// this is calling the function and providing the solution
var count = 0
allOrbitingObj.forEach {
    count += countParent(planet: $0.value)
}
print("Solution Day 6 part 1 is : \(count)")

// Day 6: Universal Orbit Map part 2
// create my minimum counting orbits func. The .value here in the func is because of accessing the SpaceObject from the dic 
// allOrbitingObj is a dic with key : String and value: SpaceObject. Search function is in utilities file.
func minNumTransfers(allOrbitingObj: [String : SpaceObject], from: String, to: String) -> Int {
    var commonParents: [SpaceObject] = []
    allOrbitingObj.forEach { spaceObject in
        if spaceObject.value.search(name: "YOU") != nil && spaceObject.value.search(name: "SAN") != nil {
                commonParents.append(spaceObject.value)
        }
    }
    let minOrbits: Int = commonParents.map {
        countOrbits(spaceObject: $0, child: allOrbitingObj[from]!) + countOrbits(spaceObject: $0, child: allOrbitingObj[to]!)
    }.min()!
    print("Solution Day 6 part 2 is \(minOrbits)")
    return 0
}
// create a utility counting orbits func 
func countOrbits(spaceObject: SpaceObject, child: SpaceObject) -> Int {
    var count = 0
    if let a = child.parentObject  {
        if a != spaceObject {
        count = 1 + countOrbits(spaceObject: spaceObject, child: a)
        }
    }
    return count
}

// this call will give the solution to part 2
minNumTransfers(allOrbitingObj: allOrbitingObj, from: "YOU", to: "SAN")

```

## [Day 7: Amplification Circuit](https://adventofcode.com/2019/day/7)

Based on the navigational maps, you're going to need to send more power to your ship's thrusters to reach Santa in time. To do this, you'll need to configure a series of amplifiers already installed on the ship.

There are five amplifiers connected in series; each one receives an input signal and produces an output signal. They are connected such that the first amplifier's output leads to the second amplifier's input, the second amplifier's output leads to the third amplifier's input, and so on. The first amplifier's input value is 0, and the last amplifier's output leads to your ship's thrusters.

The Elves have sent you some Amplifier Controller Software (your puzzle input), a program that should run on your existing Intcode computer. Each amplifier will need to run a copy of the program.

 [...]
 
 Try every combination of phase settings on the amplifiers. What is the highest signal that can be sent to the thrusters?

```swift
import Foundation

var phases = [0,1,2,3,4] // This can be any array
var phaseSettings = [[Int]]()

// phasePermutation is in the util functions
phasePermutation(phases: &phases) { result in phaseSettings.append(result) }

// func getInput is in utilities file
var input = getInput(inputFile: "input7", extension: "txt")

//get the input file as an array into program
var program = input.components(separatedBy: ",").compactMap { Int($0) }

// map! for each array in phaseSettingsFeedback I get a variable phases like [2, 0, 1, 3, 4]
let amplifiedOutput: Int = phaseSettings.map { phases in
    // computed property inside the closure. again with map. for every value in phases I create a Computer running his own version of the program taking one phase each as input 2, 0, 1, 3, 4
    // start
    var input = 0
// loop over the program until one of the computer gets to opcode 99
    for i in 0...4 {
       var computer = Computer(program: program, inputs: [phases[i], input])
       computer.runProgramUntilEnd()
       input = computer.getOutput()
    }
    // return what would be the last output
    return input
// get the max out of all values
}.max()!

// part 2
var phasesFeedback = [9,8,7,6,5] // this is for part 2
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
            if let output = amplifiers[i].runProgram() {
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
```

## [Day 8: Space Image Format](https://adventofcode.com/2019/day/8)

The Elves' spirits are lifted when they realize you have an opportunity to reboot one of their Mars rovers, and so they are curious if you would spend a brief sojourn on Mars. You land your ship near the rover.

When you reach the rover, you discover that it's already in the process of rebooting! It's just waiting for someone to enter a BIOS password. The Elf responsible for the rover takes a picture of the password (your puzzle input) and sends it to you via the Digital Sending Network.

Unfortunately, images sent via the Digital Sending Network aren't encoded with any normal encoding; instead, they're encoded in a special Space Image Format. None of the Elves seem to remember why this is the case. They send you the instructions to decode it.
 [...]
 
 The image you received is 25 pixels wide and 6 pixels tall.

 To make sure the image wasn't corrupted during transmission, the Elves would like you to find the layer that contains the fewest 0 digits. On that layer, what is the number of 1 digits multiplied by the number of 2 digits?
 

```swift
import Foundation

// this from Paul Hudson to split arrays into chunks!! 😬🙌
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
// a picture is made of layers
struct Layer {
    var width: Int
    var height: Int
    var data: [Int]
    func returnPixelValue(row: Int, col: Int) -> Int {
        return data[row * width + col]
    }
}
// I use a custom init. A picture is actually an array of layers
struct Picture {
    var layers: [Layer]
    init(data: [Int], width: Int, height: Int)  {
        layers = [Layer]()
        let pixelPerLayer = width * height
        let layerCount = data.count / pixelPerLayer
        // this is an array of layers!
        let dataPerLayer = data.chunked(into: pixelPerLayer)
        // split digits by layer
        for i in 0..<layerCount {
            // create a new layer and fill it with pixels
            layers.append(Layer(width: width, height: height, data: dataPerLayer[i]))
        }
    }
   
}
// this enum is because it looks good
enum Color: Int {
    case black = 0,
        white = 1,
        transparent = 2
}

// func getInput is in utilities file
var input = getInput(inputFile: "input8", extension: "txt")
let len = input.count
// had to filter because it did add a 0 at the end otherwise. I coalesce to -1 in map and take the -1 away in filter
var data = input.map { Int($0.string) ?? -1} // .filter { $0 != -1} this is kinda expensive so I will just take out the last element of the array this time!
//print(data)

let picture = Picture(data: data, width: 25, height: 6)

// this again is from Paul. my layer is mapped to a dict with keys 0, 1, 2 for the colors and value is the amount of them.
func getTheDigitsCount(data: [Int], digit: Int) -> Int {
    //convert data to an array of key-value pairs using tuples, where each value is the number 1:
    let mappedItems = data.map { ($0, 1) }
    // create a Dictionary from that tuple array, asking it to add the 1s together every time it finds a duplicate key:
    let counts = Dictionary(mappedItems, uniquingKeysWith: +)
    //That will create the dictionary ex [1: 1, 0: 2, 2: 1] because dictionaries are not stored in order – as you can see, it tells us that “0” appeared twice, while the other two appeared once.
    return counts[digit] ?? 0
}
// countzeroes is a tuple, well why not 😀👍🏻 it is like a dictionary, I stored the index with the number of zeroes
var countZeroes = (0,getTheDigitsCount(data: picture.layers[0].data, digit: 0))
// dropFirst allows me to safely iterate through layers droppint the first element
for (index,layer) in picture.layers.dropFirst().enumerated() {
    // countZeroes.1 is the second elem of my tuple, the first one is the index
    if countZeroes.1 > getTheDigitsCount(data: layer.data, digit: 0) {
        countZeroes = (index,getTheDigitsCount(data: layer.data, digit: 0))
    }
}
let layerWithFewestZeroes = countZeroes.0 + 1 // +1 because I dropped the first index
print("the layer with the fewest zeroes is \(countZeroes.0 + 1). Number of zeroes is \(countZeroes.1)")
let countOfOnes = getTheDigitsCount(data: picture.layers[layerWithFewestZeroes].data, digit: 1)
let countOfTwos = getTheDigitsCount(data: picture.layers[layerWithFewestZeroes].data, digit: 2)
// solution part one
print("The solution to part one is \(countOfOnes * countOfTwos)")

// -- part two ---

func mergeColors(_ colors: [Color]) -> Color {
    var next = colors[0]
    var idx = 0
    while .transparent == next && idx < colors.count {
        next = colors[idx]
        idx += 1
    }
    return next
}
var finaldata = [Color]()
var colors: [Color]
for row in 0..<6 {
    for col in 0..<25 {
        colors = picture.layers.map{Color(rawValue: ($0.returnPixelValue(row: row, col: col))) ?? .transparent }
        finaldata.append(mergeColors(colors))
    }
}

func printPicture(data: [Color]) {
    for i in 0..<6 {
        print("")
        for j in 0..<25 {
            switch data[i * 25 + j] {
            case .black: print("■", terminator: "" )
            case .white: print("❑", terminator: "")
            case .transparent: print(".", terminator: "")
            }
        }
    }
}
print("\nSolution to part two: ")
printPicture(data: finaldata)
```

## [Day 9: Sensor Boost](https://adventofcode.com/2019/day/9)

It has been hard because I had to refactor the input program from array to dict to contain the huge jumps in the program. At the end the code does look horrible though unwrapping all those optionals in dict! I will need to clean up this one further!

```swift
// I used this to transform the input array into a dict which can be accessed at program[index] 
// however this is an optional... advantage is that if I save data at index 123456666 it wont be a problem!
var program = Dictionary(uniqueKeysWithValues: zip(0..., inputProgramArray))

// the rest is similar to the other intcode challenges and it is in the playground!
```

## [Day 10: Monitoring Station](https://adventofcode.com/2019/day/10)

The code works but written quiclky and needs some refactoring

```swift
import Foundation
// this is to get the character of the string with subscript like string[3] - it would not be possible in swift!
// I thought I was being smart but this extension is the most expensive in the whole program! need to refactor this
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
// func getInput is in utilities file
var input = getInput(inputFile: "input10", extension: "txt")
//get the input file as an array into program
var asteroidMap: [String] = input.components(separatedBy: "\n").filter { $0 != "" }
// print the map for debugging
for i in 0..<asteroidMap.count {
    print(asteroidMap[i], terminator: "\n")
}
//my universe
struct Universe {
    var asteroidMap: [String]
    lazy var xBounds = asteroidMap[0].count
    lazy var yBounds = asteroidMap.count
    var monitoringStation = Asteroid()
    var asteroidsArray = [Asteroid]()
    
    mutating func startPulverizingBeam() {
        var count = 0
        while asteroidsArray.isEmpty == false {
            let a = pulverizeOneAsteroid()
            count += 1
            print("pulverized \(a.description) asteroid number \(count)\n")
            if count == 200 {
                a.origLocation.xPos
                print("\n solution is \(a.origLocation.xPos * 100 + a.origLocation.yPos)\n 😀 ")
                return
            }
           }
        return
    }
    init(asteroidMap: [String]) {
        self.asteroidMap = asteroidMap
        self.setMonitorinStation()
    }
    mutating func pulverizeOneAsteroid() -> Asteroid {
        if asteroidsArray.isEmpty { return monitoringStation }
        return asteroidsArray.removeFirst()
    }
    mutating func sortAsteroidsArray() {
        if asteroidsArray.isEmpty { getAsteroidsArrayFromMonitoringStation() }
        // this is to sort arrays first time by angle ASC and for same angle by radius ASC
        asteroidsArray.sort{
            if $0.polarCoordinatesFromMonitoringStation.angle == $1.polarCoordinatesFromMonitoringStation.angle {
                return $0.polarCoordinatesFromMonitoringStation.radius < $1.polarCoordinatesFromMonitoringStation.radius
            } else {
                return $0.polarCoordinatesFromMonitoringStation.angle < $1.polarCoordinatesFromMonitoringStation.angle
            } }
        // again sort and assign the orderNumber
        // k is keeping track of how many same elements are at the end of the array. without k there would be an endless loop at the end removing and appending the same element!
        var i = 0; let j = asteroidsArray.count ; var k = 0
        while i < (j - k) {
            if i == 0  {
                asteroidsArray[0].asteroidNumber = 0
                i = i + 1; continue  }
            // the twist. everytime I discover a new sameness of angles k needs to start at zero. K will always give me the number of same elements at the very bottom of the array which if it got k times the same elements will not need to be iterated to
            if asteroidsArray[i].polarCoordinatesFromMonitoringStation.angle == asteroidsArray[i - 1].polarCoordinatesFromMonitoringStation.angle {k = 0}
            // compare to the previous angle, if same then remove and append as long as needed
            while asteroidsArray[i].polarCoordinatesFromMonitoringStation.angle == asteroidsArray[i - 1].polarCoordinatesFromMonitoringStation.angle {
                    let a = asteroidsArray.remove(at: i)
                    asteroidsArray.append(a)
                    // I update k to say this has been done a number of time.
                    k = k + 1
                    continue
                }
            
            //asteroidsArray[i].asteroidNumber = i
            i = i + 1
        }
    }
    //looping to every corner of my universe. I check from every asteroid I land which one is the one with the most visible asteroids
    mutating func chooseMonitorinStation() -> Asteroid {
        var location: (xPos: Int, yPos: Int) = (xPos : 0, yPos: 0)
        var sightings = 0
        for y in 0..<self.yBounds {
            for x in 0..<self.xBounds{
                if self.asteroidMap[y][x] == "#" {
                    let thisAsteroidSightings = checkVisibleAsteroidFrom(coordinates: (xPos : x, yPos: y))
                    if thisAsteroidSightings > sightings {
                        sightings = thisAsteroidSightings
                        location = (xPos: x, yPos: y)
                    }
                } else { continue }
            }
        }
        print("\nMax asteroids sightings: \(sightings) for the asteroid at coordinates \(location)\nThis is the Monitoring station! saved in Universe! \n")
        self.monitoringStation = Asteroid(origLocation: location, polarCoordinatesFromMonitoringStation: (angle: 0, radius: 0), asteroidNumber: 0)
        return monitoringStation
    }
    // sometimes I need to set the monitoring station by myself lloking for the big X in the map
    mutating func setMonitorinStation() -> Asteroid {
        for y in 0..<self.yBounds {
            for x in 0..<self.xBounds{
                if self.asteroidMap[y][x] == "X" {
                    self.monitoringStation = Asteroid(origLocation: (xPos : x, yPos: y), polarCoordinatesFromMonitoringStation: (angle: 0, radius: 0), asteroidNumber: 0)
                    return monitoringStation
                }
            }
        } // if X not found then I just go down the normal route
        return chooseMonitorinStation()
    }
     //from one asteroid at pos xPos yPos , I return the number of unique asteroids(angles) I see and return a set of unique values
    mutating func checkVisibleAsteroidFrom(coordinates: (xPos : Int, yPos: Int)) -> Int{
        var angles = Set<Double>()
        for y in 0..<self.yBounds {
            for x in 0..<self.xBounds{
                if y == coordinates.yPos && x == coordinates.xPos { continue }
                if self.asteroidMap[y][x] == "#" {
                // from rwenderlich For this specific problem, instead of using atan(), it’s simpler to use the function atan2(_:_:), which takes the x and y components as separate parameters, and correctly determines the overall rotation angle.
                    let (angle, _): (Double, Double) = convertToPolar(x: Double(x - coordinates.xPos) ,y: Double(y - coordinates.yPos))
                    angles.insert( angle )
                    } else { continue }
            }
        }
        return angles.count
    }
    mutating func getAsteroidsArrayFromMonitoringStation() -> [Asteroid]  {
       
        for y in 0..<self.yBounds {
            for x in 0..<self.xBounds{
                if self.asteroidMap[y][x] == "#" {
                    if y == self.monitoringStation.origLocation.yPos && x == self.monitoringStation.origLocation.xPos { continue }
                // from rwenderlich For this specific problem, instead of using atan(), it’s simpler to use the function atan2(_:_:), which takes the x and y components as separate parameters, and correctly determines the overall rotation angle.
                    let (angle, radius): (Double, Double) = convertToPolar(x: Double(x - self.monitoringStation.origLocation.xPos) ,y: Double(y - self.monitoringStation.origLocation.yPos))
                    let asteroid = Asteroid(origLocation: (xPos: x, yPos: y), polarCoordinatesFromMonitoringStation: (angle: angle , radius: radius))
                    asteroidsArray.append(asteroid)
                } else { continue }
            }
        }
        return asteroidsArray
    }
    
    func getRadius(_ a: Double, _ b: Double) -> Double {
        return (a * a + b * b).squareRoot()
    }
    func convertToPolar(x: Double ,y: Double) -> (Double, Double) {
        let radius: Double = getRadius(x, y)
        let degreesToRadians = Double(CGFloat.pi / 180)
            var angle = (-atan2(-y,x) + degreesToRadians * 90)
            if angle < 0 {
                angle = angle + 360 * degreesToRadians
                return (angle, radius)
            }
            return (angle, radius)
    }
}
struct Asteroid {
    var origLocation: (xPos: Int, yPos: Int) = (xPos : 0, yPos: 0)
    var polarCoordinatesFromMonitoringStation: (angle: Double, radius: Double) = (angle: 0 , radius: 0)
    var asteroidNumber: Int?
    //lazy var sightings: Int =
}
extension Asteroid: CustomStringConvertible {
  //This is a computed property. Mapping will be recursive!
    public var description: String {
        var text = ""
        if let order = asteroidNumber {
            text = "Asteroid number: \(order) \n" }
        text += "Polar coordinates \(polarCoordinatesFromMonitoringStation) \n  "
        return text
    }
}

var santaUniverse = Universe(asteroidMap: asteroidMap)
print("bounds x:\(santaUniverse.xBounds) y:\(santaUniverse.yBounds)")
santaUniverse.getAsteroidsArrayFromMonitoringStation()
santaUniverse.sortAsteroidsArray()
santaUniverse.startPulverizingBeam()

```

## [Day 11: Space Police](https://adventofcode.com/2019/day/11)

On the way to Jupiter, you're pulled over by the Space Police.

"Attention, unmarked spacecraft! You are in violation of Space Law! All spacecraft must have a clearly visible registration identifier! You have 24 hours to comply or be sent to Space Jail!"

Not wanting to be sent to Space Jail, you radio back to the Elves on Earth for help. Although it takes almost three hours for their reply signal to reach you, they send instructions for how to power up the emergency hull painting robot and even provide a small Intcode program (your puzzle input) that will cause it to paint your ship appropriately...

```swift

struct Robot {
    var program: [Int: Int] = [:]
    var direction: Direction = .up
    var paintedSquares = Set<Square>()
    var currentSquare: Square
    //var program: [Instruction]
    init(inputFile: String) {
        //initialize the current square--- for part two it will start white!
        self.currentSquare = Square(color: .white, coordinatesFromStart: (xPos: 0, yPos: 0))
        // load the program as dictionary of memory locations
        self.loadProgram(inputFile: inputFile)
    }
    mutating func paintSquare(color: Color){
        self.currentSquare.color = color
        //Return Value is (true, newMember) if newMember was not contained in the set. If an element equal to newMember was already contained in the set, the method returns (false, oldMember), where oldMember is the element that was equal to newMember.
        if self.paintedSquares.insert(currentSquare).0 == false {
            print("you have been here before")
            self.paintedSquares.update(with: currentSquare)
            print("updated with \(currentSquare.color)\n")
        }
        print("color is now \(self.currentSquare.color)")
    }
    func returnColorAtCurrentSquare() -> Color {
        return self.currentSquare.color
    }
    mutating func moveOneSquare(){
        switch self.direction {
            case .up:
                print("\nGoing Up")
                self.currentSquare.coordinatesFromStart.yPos -= 1
                print("position \(self.currentSquare.coordinatesFromStart)")
            case .right:
                print("\nGoing right")
                self.currentSquare.coordinatesFromStart.xPos += 1
                print("position \(self.currentSquare.coordinatesFromStart)")
            case .left:
                print("\nGoing left")
                self.currentSquare.coordinatesFromStart.xPos -= 1
                print("position \(self.currentSquare.coordinatesFromStart)")
            case .down:
                print("\nGoing down")
                self.currentSquare.coordinatesFromStart.yPos += 1
                print("position \(self.currentSquare.coordinatesFromStart)")
            }
        // need to update currentSquare after moving. if i already visited that square then the color could be white or black. else is black by defaault
        if let alreadyVisited = self.paintedSquares.first(where: { $0.coordinatesFromStart == self.currentSquare.coordinatesFromStart }) {
            self.currentSquare.color = alreadyVisited.color
        } else {
            self.currentSquare.color = .black
        }
        print("currentSquare color \(self.currentSquare.color)")
        print("number of square visited = \(self.paintedSquares.count) \n\n")

    }
    mutating func changeDirection(to: Direction) {
        switch to {
            case .left:
                self.direction = Direction(rawValue: ((self.direction.rawValue + 4 - 1) % 4) )!
                
            case .right:
                self.direction = Direction(rawValue: ((self.direction.rawValue + 4 + 1) % 4) )!
            default: print("\nOnly left or right changes allowed! \n")
        }
        self.direction
    }
    mutating func loadProgram(inputFile: String) {
        // func getInput is in utilities file
        let input = getInput(inputFile: inputFile, extension: "txt")
        //get the input file as an array into program
        let inputProgramArray = input.components(separatedBy: ",").compactMap { Int($0) }
        let progrLength = inputProgramArray.count
        //var programBuffer = [Int](repeating: 0, count: 100000000)
        print("last two : \(inputProgramArray[progrLength-2]) == \(inputProgramArray[progrLength-1])")
        self.program = Dictionary(uniqueKeysWithValues: zip(0..., inputProgramArray))
    }
    mutating func runProgram() {
        print(self.program)
        var index = 0; var relativeBase = 0; var outputs = [Int]();  var input: Int = 0
        print(index)
        print(outputs)
        // the index will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
        //while outputs.count != 1 {
        while program[index] != 99 {
            //print("Prog: \(program)")
            // just in case initialize some memory here
            for i in 0..<4 {
                if index <= 0 { index = 0 }
                if program[index + i] == nil { program[index + i] == 0 }
                if program[index]! / 10000 > 3 { print("\n error opcode =================\n "); break }
            }
            print("instr range: \(program[index] ?? 0) - \(program[index+1] ?? 0) - \(program[index+2] ?? 0) - \(program[index+3] ?? 0)")
            print("index: \(index)")
            print("relativeBase: \(relativeBase)")
                        
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
                    input = self.returnColorAtCurrentSquare().rawValue
                    print("\n TEST Input is current color of square: \(Color(rawValue: input)!) ")
                    var firstParam = 0
                    if instruction.modes[0] == .position {
                            if let a = program[index + 1] {
                                firstParam = a }}
                    else if instruction.modes[0] == .relative {
                            if let a = program[index + 1] {
                                firstParam = a + relativeBase }}
                        else {
                            print("\n\nerror write cannot have immediate mode 1 \n\n")
                    }
                    program[firstParam] = input
                    print("value: \(input)  written to \(firstParam)")
                    print("is this right ? \(program[firstParam]!)\n")
                    index += 2
                case .output:
                    print("output got: \(instruction.parameters[0])")
                    outputs.append(instruction.parameters[0])
                    if outputs.count == 2 {
                        print("outputs are \(outputs)")
                        print("painting \(Color(rawValue: outputs[0]) ?? .black) and moving one square")
                        self.paintSquare(color: Color(rawValue: outputs[0]) ?? .black)
                        if outputs[1] == 1 { outputs[1] += 1 }// to get turn right}
                            self.changeDirection(to: Direction(rawValue: outputs[1]) ?? .up)
                        self.moveOneSquare()
                        outputs = []
                    }
                    index += 2
                    
                    print("continue with \(program[index]!)\n")
                case .jumpIfTrue:
                    //Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
                    print("jumpIfTrue")
                    print( instruction.parameters)
                    //print("range: \(program[index...index+2])")
                    if instruction.parameters[0] != 0 {
                        index = instruction.parameters[1]
                        print("jump to index \(index)\n")
                        continue
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
    printSolution() 
    }
}
struct Square: Hashable {
    // this is tricking swift to make sets of spaceobjects. The class needs to conform to hashable and equatable.
    static func == (lhs: Square, rhs: Square) -> Bool {
        return lhs.coordinatesFromStart == rhs.coordinatesFromStart
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(coordinatesFromStart.xPos)
        hasher.combine(coordinatesFromStart.yPos)
        }
    var color: Color = .black
    var coordinatesFromStart: (xPos: Int, yPos: Int)
    mutating func paintSquare() {
        
    }
    
}
enum Direction: Int {
    case left, up, right, down
}
enum Color: Int {
    case  black, white
}

```

## [Day 12: The N-Body Problem](https://adventofcode.com/2019/day/12)

The space near Jupiter is not a very safe place; you need to be careful of a big distracting red spot, extreme radiation, and a whole lot of moons swirling around. You decide to start by tracking the four largest moons: Io, Europa, Ganymede, and Callisto.

After a brief scan, you calculate the position of each moon (your puzzle input). You just need to simulate their motion so you can avoid them.

Each moon has a 3-dimensional position (x, y, and z) and a 3-dimensional velocity. The position of each moon is given in your scan; the x, y, and z velocity of each moon starts at 0.

Simulate the motion of the moons in time steps. Within each time step, first update the velocity of every moon by applying gravity. Then, once all moons' velocities have been updated, update the position of every moon by applying velocity. Time progresses by one step once all of the positions are updated.

To apply gravity, consider every pair of moons. On each axis (x, y, and z), the velocity of each moon changes by exactly +1 or -1 to pull the moons together. For example, if Ganymede has an x position of 3, and Callisto has a x position of 5, then Ganymede's x velocity changes by +1 (because 5 > 3) and Callisto's x velocity changes by -1 (because 3  `<` 5). However, if the positions on a given axis are the same, the velocity on that axis does not change for that pair of moons.

Once all gravity has been applied, apply velocity: simply add the velocity of each moon to its own position. For example, if Europa has a position of x=1, y=2, z=3 and a velocity of x=-2, y=0,z=3, then its new position would be x=-1, y=2, z=6. This process does not modify the velocity of any moon.

What is the total energy in the system after simulating the moons given in your scan for 1000 steps?

I started by cleaning up the input in a usable way... not so nice in Swift. Python is way easier for that! Anyway..

```swift
import Foundation

// Regex in Swift have a slightly clumsy syntax thanks to their Objective-C roots.
// This is my input file
var input = getInput(inputFile: "input12b", extension: "txt")
// to replace or remove text in a string in swift I could use replacingOccurrences(of:, with:) but in this case Regex is better, however certainly somewhat cumbersome. Not so nice like in python though
let regex = try! NSRegularExpression(pattern: "[<=xyz\n]")
let range = NSRange(input.startIndex..., in: input)
var moons = regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: "").split(separator: ">").map{ String($0).split(separator: ",").compactMap { NumberFormatter().number(from: String($0))?.intValue }}
//print(moons)

struct Moon {
    var name: String
    var position: [Int] = [Int]()
    var velocity: [Int] = [0,0,0]
    lazy var potentialEnergy = position.compactMap { abs($0) }.reduce(0, +)
    lazy var kineticEnergy = velocity.compactMap { abs($0) }.reduce(0, +)
    lazy var moonTotalEnergy = potentialEnergy * kineticEnergy
    init(name: String, position:[Int]) {
       self.position = position
        self.name = name
    }
    mutating func setVelocity(_ newvelocity: [Int]) {
        self.velocity = newvelocity
    }
    mutating func updatePosition() {
        let newPosition = zip(self.position, self.velocity).map(+)
        print(newPosition)
        self.position = newPosition
    }
}

struct Jupyter {
    var moons = [Moon]()
    var originalPosition = [[Int]]()
    // this init takes the positions of all the moons as in the input file and create the array of moons
    init(positions: [[Int]], names: [String]) {
        for i in 0..<positions.count {
            let moon = Moon(name: names[i], position: positions[i])
            self.originalPosition = positions
            self.moons.append(moon)
        }
        print("originalPosition \(originalPosition)")
    }

    mutating func getTotalEnergy() -> Int {
        var totalEnergy = 0
        for i in 0..<moons.count  {
            print(moons[i].potentialEnergy)
            print(moons[i].kineticEnergy)
            totalEnergy += moons[i].moonTotalEnergy
        }
        return totalEnergy
    }
    mutating func step() {
        //calculateVelocity. Repeating for the number of moons = 4 times
        for _ in 0..<moons.count {
            // because I use structs I remove the first element of the array and append at the end to get the updated array
            var moon = self.moons.removeFirst()
            // this is to crucial debug if I was doing it right!
            print("position \(moon.position)")
            print("velocity : \(moon.velocity)")
            var newVelocity = moon.velocity
            //Repeating for the number of moons now 3 times because I removed the first
            for j in 0..<self.moons.count {
                // and for each axe I calculate the new velocity
                for k in 0..<3 {
                    if moon.position[k] > self.moons[j].position[k] {
                        newVelocity[k] -= 1
                    } else if moon.position[k] < self.moons[j].position[k] {
                        newVelocity[k] += 1
                    } else { continue }
                }
            }
            // update and append again. After 4 times the array is updated with 4 new moons
            moon.setVelocity(newVelocity)
            self.moons.append(moon)
            print("new velocity : \(newVelocity)")
        }
        // now need to again update the position adding the old position with velocity
        for _ in 0..<moons.count {
            var moon = self.moons.removeFirst()
            let newPosition = zip(moon.position, moon.velocity).map(+)
            print("\nnew calculated position: \(newPosition)")
            moon.position = newPosition
            self.moons.append(moon)
        }
     }
    
    mutating func runNumberOf(steps: Int) {
        for _ in 0..<steps  {
            self.step()
        }
        print("\n\nPart one solution! Total Energy after \(steps) steps is \(getTotalEnergy())\n")
    }

    mutating func stepPerDimension(axis: Int) -> Int {
        let moonCount = moons.count
        //calculateVelocity
        // declaring dictionaries for max speed
        var positionPerDimension = [Int: Int]()
        var velocityPerDimension = [Int: Int]()
        //initialize
        for i in 0..<moonCount{
            positionPerDimension[i] = moons[i].position[axis]
            velocityPerDimension[i] = 0
         }
        print("initialized!")
        print(positionPerDimension)
        print(velocityPerDimension)
        // save the beginning state
        let origPositionPerDimension = positionPerDimension
        let origVelocityPerDimension = velocityPerDimension
         
        var number = 0
        repeat {
            number += 1
            for i in 0..<moonCount{
                
                for j in 1..<moonCount {
                    let k = (i + j) % moonCount
                    if positionPerDimension[i]! > positionPerDimension[k]! {
                        velocityPerDimension[i]! -= 1
                    } else if positionPerDimension[i]! < positionPerDimension[k]! {
                        velocityPerDimension[i]! += 1
                    }
                }
            }
            print("old position \(positionPerDimension) merging \(velocityPerDimension)")
            positionPerDimension.merge(velocityPerDimension, uniquingKeysWith: +)
            print("new position \(positionPerDimension)")
            
        } while (positionPerDimension != origPositionPerDimension) || (origVelocityPerDimension != velocityPerDimension)
        print(number)
        return number
    }
    
                
}

// Part one!
var jupyter = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
// solution part one is outup of this function
jupyter.runNumberOf(steps: 1000)

//Part2
// for every axis I calculate the number of steps to get to the initial state. In this challenge the axis are indipendent so i do not need to get the initial state of all three axis x, y , z at the same time. Just one at the time and then the total number of steps for the three axis to be in the initial state will be the lowest common multiplier!
// the lcm algo is in the sources folder. I made a new step per dimension method for part two. paramether is axis x is 0 y is 1 and z is 2
let a = jupyter.stepPerDimension(axis: 0)
let b = jupyter.stepPerDimension(axis: 1)
let c = jupyter.stepPerDimension(axis: 2)
let solutionPart2 = lcm(a,b,c)

print("\n\nPart two solution! Total number of steps is \(solutionPart2)\n")


```

## [Day 13: Care Package](https://adventofcode.com/2019/day/13)
(click on title to get the full challenge description on aoc website)
As you ponder the solitude of space and the ever-increasing three-hour roundtrip for messages between you and Earth, you notice that the Space Mail Indicator Light is blinking. To help keep you sane, the Elves have sent you a care package.

From now on I will have to push some files away from the main pplayground for better performance
In this case I put my IntComputer in his own class separate.. then counting the tiles 

```swift

let a = IntCodeComputer(program: program)

let outputs = a.run()

public enum TileType: Int {
    case empty = 0
    case wall
    case block
    case horizontalPaddle
    case ball
}

struct Coordinate: Hashable {
    let x: Int
    let y: Int
}

public struct Tile : Hashable {
    var coordinates: Coordinate
    var type: TileType
}
var tiles = Set<Tile>()
for i in stride(from: 0, to: 3105, by: 3) {
    print(i, outputs[i + 2] )
    tiles.insert(Tile(coordinates: Coordinate(x: outputs[i], y: outputs[i + 1]), type: TileType(rawValue: outputs[i + 2])!))
    }
let blockCount = tiles.filter { $0.type == .block }.count
print("Solution part 1 is block count: \(blockCount)")

```




If you hit problems or have questions, you're welcome to tweet me [@wrmultitudes](https://twitter.com/wrmultitudes).


