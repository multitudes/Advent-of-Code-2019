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
var input = getInput(inputFile: "input12a", extension: "txt")
// to replace or remove text in a string in swift I could use replacingOccurrences(of:, with:) but in this case Regex is better, however certainly somewhat cumbersome. Not so nice like in python though
let regex = try! NSRegularExpression(pattern: "[<=xyz\n]")
let range = NSRange(input.startIndex..., in: input)
var moons = regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: "").split(separator: ">").map{ String($0).split(separator: ",").compactMap { NumberFormatter().number(from: String($0))?.intValue }}
print(moons)

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
    init(positions: [[Int]], names: [String]) {
        for i in 0..<positions.count {
            let moon = Moon(name: names[i], position: positions[i])
            self.originalPosition = positions
            print(originalPosition)
            self.moons.append(moon)
        }
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
    mutating func step() -> Bool {
        var flag  = [Int](repeating: 0, count: moons.count)
        //calculateVelocity
        for i in 0..<moons.count {
            var moon = self.moons.removeFirst()
            print("position \(moon.position)")
            print("velocity : \(moon.velocity)")
            if moon.position == originalPosition[i] && moon.velocity == [0,0,0] {
                flag[i] = 1
            } else {
                flag[i] = 0
            }
            var newVelocity = moon.velocity
            for j in 0..<self.moons.count {
                for k in 0..<3 {
                    if moon.position[k] > self.moons[j].position[k] {
                        newVelocity[k] -= 1
                    } else if moon.position[k] < self.moons[j].position[k] {
                        newVelocity[k] += 1
                    } else { continue }
                }
            }
            moon.setVelocity(newVelocity)
            self.moons.append(moon)
            print("new velocity : \(newVelocity)")
            
        }
        //print(self.moons)
        for i in 0..<moons.count {
            var moon = self.moons.removeFirst()
            let newPosition = zip(moon.position, moon.velocity).map(+)
            print("\nnew calculated position: \(newPosition)")
            moon.position = newPosition
            self.moons.append(moon)
            print(self.moons[3])
        }
        return flag.reduce(0, + ) == moons.count
     }
    mutating func runNumberOf(steps: Int) {
        for i in 0..<steps  {
            self.step()
        }
        print("Total Energy after \(steps) steps is \(getTotalEnergy())")
    }
    mutating func findNumberOfSteps() {
        var number = 0
        var flag = false
        repeat {
            flag = step()
            number += 1
        } while !flag || number == 1
        print("number of steps is : \(number - 1 )")
    }
}

//var jupyter = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])

//// solution part one is outup of this function
//jupyter.runNumberOf(steps: 10)

// this is for input12b result 1940
//var jupyter2 = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
//
//jupyter2.runNumberOf(steps: 100)

var jupyter = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
//// solution part one is outup of this function
//jupyter.runNumberOf(steps: 1000)

jupyter.findNumberOfSteps()

extension Moon: CustomStringConvertible {
  //This is a computed property.
    var description: String {
        var text = "name: \(name) position \(position) velocity \(velocity)"
        return text
    }
}
