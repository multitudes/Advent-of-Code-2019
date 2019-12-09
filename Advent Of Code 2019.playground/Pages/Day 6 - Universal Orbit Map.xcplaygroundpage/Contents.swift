//: [Previous](@previous)
/*:
# Day 6: Universal Orbit Map

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
You've landed at the Universal Orbit Map facility on Mercury. Because navigation in space often involves transferring between orbits, the orbit maps here are useful for finding efficient routes between, for example, you and Santa. You download a map of the local orbits (your puzzle input).

: [Next](@next)
*/

import Foundation
// func getInput is in utilities file
var input = getInput(inputFile: "input6", extension: "txt")
//get the input file as an array into program
var map = input.components(separatedBy: "\n").filter { $0 != "" }
print("map: \(map)")

class SpaceObject : Hashable {
    var value: String
    var orbitingObjects:[SpaceObject] = []
    weak var parentObject: SpaceObject? // this is the parent. not every object got a parent. weak to avoid retain cycles.
    init(value: String) {
        self.value = value
    }
    func add(orbitingObject: SpaceObject) {
        orbitingObjects.append(orbitingObject)
        orbitingObject.parentObject = self //once I add an orbiting object (child) then I become a center object (parent) of the child
    }
    // this is tricking swift to make sets of spaceobjects. The class needs to conform to hashable and equatable.
    static func == (lhs: SpaceObject, rhs: SpaceObject) -> Bool {
        return lhs.value == rhs.value
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
// test let map = ["YY6)PRG"]
var planet : [String] = []
//var allOrbitingObj = Set<SpaceObject>()
var allOrbitingObj = [String : SpaceObject]()

for i in 0..<map.count {
    // planet will be an array of two planets
    planet = map[i].components(separatedBy: ")")
    // check if child exists in dict, key is planet[..] and if not create and add it
    if  allOrbitingObj[planet[1]] == nil {
        let objChild = SpaceObject(value: planet[1])
        allOrbitingObj[planet[1]] = objChild
    }
    // check if parent exists and if not create it
    if  allOrbitingObj[planet[0]] == nil {
        let objParent = SpaceObject(value: planet[0])
        allOrbitingObj[planet[0]] = objParent
    }
    // check if parent exists and if so add the child
    if let objParent = allOrbitingObj[planet[0]], let objChild = allOrbitingObj[planet[1]] {
        objParent.add(orbitingObject: objChild)
    }

}
print(allOrbitingObj.count)
func countParent(planet : SpaceObject) -> Int {
    var count = 0
    if let parent = planet.parentObject {
        count = 1 + countParent(planet: parent)
    }
    return count
}
var count = 0
allOrbitingObj.forEach {
    count += countParent(planet: $0.value)
}
print(count)
//let formattedResults = allOrbitingObj.mapValues { countParent(planet: $0 )  }
//print(formattedResults)
extension SpaceObject: CustomStringConvertible {
  //This is a computed property. Mapping will be recursive!
    var description: String {
        var text = "\(value)"
        if !orbitingObjects.isEmpty {
          text += " {" + orbitingObjects.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }

    func search(value: String) -> SpaceObject? {
        if value == self.value {
            return self
        }
        for orbitingObject in orbitingObjects {
            if let found = orbitingObject.search(value: value) {
            return found
            }
            }
        return nil
    }

}

