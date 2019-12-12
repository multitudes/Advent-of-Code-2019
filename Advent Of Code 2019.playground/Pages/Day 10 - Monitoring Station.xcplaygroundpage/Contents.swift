
//: [Previous](@previous)
/*:
# Day 10: Monitoring Station

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
You fly into the asteroid belt and reach the Ceres monitoring station. The Elves here have an emergency: they're having trouble tracking all of the asteroids and can't be sure they're safe.

The Elves would like to build a new monitoring station in a nearby area of space; they hand you a map of all of the asteroids in that region (your puzzle input).

Find the best location for a new monitoring station. How many other asteroids can be detected from that location?
 
: [Next](@next)
*/

import Foundation
// this is to get the character of the string with subscript like string[3] - it would not be possible in swift!
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
// func getInput is in utilities file
var input = getInput(inputFile: "input10a", extension: "txt")
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
   
}
struct Asteroid {
    
    //var sightings
}
//enum Position: String {
//    case asteroid = "#", noAsteroid = "."
//}

//struct coordinates {
//    let position: (Int, Int)
//}

func checkAsteroid(coordinates: (xPos: Int, yPos: Int), universe: Universe) -> Set<Double> {
    var angles = Set<Double>()
    for y in 0..<space.yBounds {
        for x in 0..<space.xBounds{
            if space.asteroidMap[y][x] == "#" {
            // from rwenderlich For this specific problem, instead of using atan(), it’s simpler to use the function atan2(_:_:), which takes the x and y components as separate parameters, and correctly determines the overall rotation angle.
            var angle = atan2(Double(y - coordinates.yPos) , Double(x - coordinates.xPos))
            angles.insert( angle )
            } else { continue }
        }
    }
    return angles
}

var space = Universe(asteroidMap: asteroidMap)

var location: (xPos: Int, yPos: Int) = (xPos : 0, yPos: 0)
var sightings = 0
for y in 0..<space.yBounds {
    for x in 0..<space.xBounds{
        if space.asteroidMap[y][x] == "#" {
            let thisAsteroidSightings = checkAsteroid(coordinates: (xPos : x, yPos: y), universe: space).count
            if thisAsteroidSightings > sightings {
                sightings = thisAsteroidSightings
                location = (xPos: x, yPos: y)
            }
        } else { continue }
    }
}
print("\nsightings: \(sightings) for asteroid at coordinates \(location)")
