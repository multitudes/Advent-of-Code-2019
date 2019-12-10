# Advent of Code 2019 for Xcode Swift Playgrounds

Advent of Code 2019 ✨🚀 Swift Solutions by 
`@multitudes` 
[Blog](https://multitudes.github.io)
|
[Twitter](https://twitter.com/wrmultitudes)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

This is a collection of self contained Swift Playgrounds with the solutions to the advent of code quizzes.
The code below is missing some parts of the code refactored in utilities files which are included in the playgrounds.

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
```


###            --- Part Two ---

```swift
import UIKit

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


If you hit problems or have questions, you're welcome to tweet me [@wrmultitudes](https://twitter.com/wrmultitudes).
