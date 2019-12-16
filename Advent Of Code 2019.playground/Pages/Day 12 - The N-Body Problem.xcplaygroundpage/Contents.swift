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
    var velocity: [Int] = [Int]()
    lazy var potentialEnergy = position.compactMap { abs($0) }.reduce(0, +)
    lazy var kineticEnergy = velocity.compactMap { abs($0) }.reduce(0, +)
    lazy var totalEnergy = potentialEnergy * kineticEnergy

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
    init(positions: [[Int]], names: [String]) {
        for i in 0..<positions.count {
            var moon = Moon(name: names[i], position: positions[i])
            self.moons.append(moon)
        }
    }
    mutating func calculatenewPositions() {
        for i in 0..<moons.count {
            moons[i].updatePosition()
        }
        print(moons)
    }
    mutating func step() {
        calculateVelocity()
        calculatenewPositions()
    }
    mutating func calculateVelocity() {
        for i in 0..<moons.count {
            var moon = self.moons.removeFirst()
            print(moon.position)
            var newVelocity = [0,0,0]
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
            //array.filter {$0.eventID == id}.first?.added = value
            //a.velocity = newVelocity
            print(newVelocity)
            
        }
        print(self.moons)
        for i in 0..<moons.count {
            var moon = self.moons.removeFirst()
            let newPosition = zip(moon.position, moon.velocity).map(+)
            print(newPosition)
            moon.position = newPosition
            self.moons.append(moon)
        }
     }
    
}

var jupyter = Jupyter(positions: moons, names: ["Io", "Europa", "Ganymede", "Callisto"])
jupyter.moons[0].potentialEnergy
jupyter.moons[1].potentialEnergy
jupyter.moons[2].potentialEnergy
jupyter.moons[3].potentialEnergy
jupyter.moons[3].kineticEnergy
jupyter.calculateVelocity()
jupyter.calculatenewPositions()
//jupyter.step()
//jupyter.step()
jupyter.calculateVelocity()
jupyter.calculatenewPositions()
 //.map{ $0.components(separatedBy: ", ") }
//input.replacingCharacters(in: nsRange, with: "<=xyz\n")
//
//planets = function(puzzle) {
//  return puzzle.replace(/[<=xyz\n]/g,'').split('>').map(p => {
//    const pos = p.split(',').map(Number);
//    const pE = pos.map(Math.abs).reduce((a,v) => a+v);
//    return {position: pos,
//            velocity: [0, 0, 0],
//            pE: pE,
//            kE: 0,
//            tE: 0
//           }
//  }).slice(0,-1);
//}
extension Moon: CustomStringConvertible {
  //This is a computed property.
    var description: String {
        var text = "name: \(name) position \(position) velocity \(velocity)"
        return text
    }
}
