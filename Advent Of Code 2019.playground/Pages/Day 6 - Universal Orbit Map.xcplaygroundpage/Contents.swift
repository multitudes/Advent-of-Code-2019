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
var planet : [String] = []
// create a dictionary. key is the planet I got and the value is the object
var allOrbitingObj = [String : SpaceObject]()

// here I fill all values in my dictionary
for i in 0..<map.count {
    // planet will be an array of two planets
    planet = map[i].components(separatedBy: ")")
    // need check if child exists in allOrbitingObj dict, key for the dic is like planet[..] "CGB" and if not create and add it
    // to add to dic need to do dict[key] = val or allOrbitingObj[planet[1]] = objChild creating the objChild on the line before
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

// this recursive function will look for all parents in my objects!
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
print("Solution is : \(count)")
