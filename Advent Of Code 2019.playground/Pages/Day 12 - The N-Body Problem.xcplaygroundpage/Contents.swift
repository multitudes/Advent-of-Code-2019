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
// debug
//var jupyter = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
//jupyter.runNumberOf(steps: 10)

// this is for input12b result 1940
//var jupyter2 = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
//jupyter2.runNumberOf(steps: 100)

var jupyter = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
// solution part one is outup of this function
jupyter.runNumberOf(steps: 1000)


extension Moon: CustomStringConvertible {
  //This is a computed property.
    var description: String {
        let text = "name: \(name) position \(position) velocity \(velocity)"
        return text
    }
}

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
