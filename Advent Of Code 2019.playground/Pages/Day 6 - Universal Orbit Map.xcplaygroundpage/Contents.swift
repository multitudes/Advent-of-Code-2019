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
print("Solution is : \(count)")


/*:
### Day 6: Universal Orbit Map part 2
*/

// func search(value: String) -> SpaceObject?

func minNumTransfers(allOrbitingObj: [String : SpaceObject], from: String, to: String) -> Int {
    var commonParents: [SpaceObject] = []
    allOrbitingObj.forEach { spaceObject in
        if spaceObject.value.search(name: "YOU") != nil && spaceObject.value.search(name: "SAN") != nil {
             print(spaceObject)
                commonParents.append(spaceObject.value)
        }
    }
    let minOrbits: Int = commonParents.map {
        countOrbits(spaceObject: $0, child: allOrbitingObj[from]!) + countOrbits(spaceObject: $0, child: allOrbitingObj[to]!)
    }.min()!
    print(commonParents)
    print(minOrbits)
    return 0
}

func countOrbits(spaceObject: SpaceObject, child: SpaceObject) -> Int {
    var count = 0
    if let a = child.parentObject  {
        if a != spaceObject {
        count = 1 + countOrbits(spaceObject: spaceObject, child: a)
        }
    }
//    if !spaceObject.orbitingObjects.isEmpty {
//        count += 1
//        countOrbits
//        if spaceObject.orbitingObjects.contains(child){
//        return count
//        }
//    }
    return count
}
minNumTransfers(allOrbitingObj: allOrbitingObj, from: "YOU", to: "SAN")
