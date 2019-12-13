
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
    var monitoringStation = Asteroid()
    var asteroidsArray = [Asteroid]()
    mutating func getVisibleAsteroidsFromMonitoringStation(coordinatesMonitoringStation: (xPos: Int, yPos: Int)) -> [Asteroid] {
        for y in 0..<self.yBounds {
            for x in 0..<self.xBounds{
                if self.asteroidMap[y][x] == "#" {
                // from rwenderlich For this specific problem, instead of using atan(), it’s simpler to use the function atan2(_:_:), which takes the x and y components as separate parameters, and correctly determines the overall rotation angle.
                    let angle: Double = atan2(Double(y - coordinatesMonitoringStation.yPos) , Double(x - coordinatesMonitoringStation.xPos))
                    let radius: Double = (Double(y - coordinatesMonitoringStation.yPos) * Double(y - coordinatesMonitoringStation.yPos) * Double(x - coordinatesMonitoringStation.xPos) * Double(x - coordinatesMonitoringStation.xPos) ).squareRoot()
                    let asteroid = Asteroid(location: (xPos: x, yPos: y), polarCoordinatesFromMonitoringStation: (angle: angle , radius: radius))
                    asteroidsArray.append(asteroid)
                } else { continue }
            }
        }
        return asteroidsArray
    }
}
struct Asteroid {
    var location: (xPos: Int, yPos: Int) = (xPos : 0, yPos: 0)
    var polarCoordinatesFromMonitoringStation: (angle: Double, radius: Double) = (angle: 0 , radius: 0)
    //lazy var sightings: Int =
}
//enum Position: String {
//    case asteroid = "#", noAsteroid = "."
//}

//struct coordinates {
//    let position: (Int, Int)
//}
// create polar coordinates for part2
var polarCoordinates:[(radius: Double, angle :Double)] = []

//from one asteroid at pos x y , I return the number of unique asteroids(angles) I see and return a set of unique values
func checkAsteroid(coordinates: (xPos: Int, yPos: Int), universe: Universe) -> Set<Double> {
    var angles = Set<Double>()
  
    for y in 0..<space.yBounds {
        for x in 0..<space.xBounds{
            if space.asteroidMap[y][x] == "#" {
            // from rwenderlich For this specific problem, instead of using atan(), it’s simpler to use the function atan2(_:_:), which takes the x and y components as separate parameters, and correctly determines the overall rotation angle.
                let angle: Double = atan2(Double(y - coordinates.yPos) , Double(x - coordinates.xPos))
                angles.insert( angle )
                let radius: Double = getRadius(Double(y - coordinates.yPos) , Double(x - coordinates.xPos))
                polarCoordinates.append((radius: radius, angle: angle))
            } else { continue }
        }
    }
    return angles
}

func getRadius(_ a: Double, _ b: Double) -> Double {
    return (a * a + b * b).squareRoot()
}

var space = Universe(asteroidMap: asteroidMap)
//looping to every corner of my universe. I check from every asteroid I land which one is the one with the most visible asteroids
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
polarCoordinates.sort(by: {$0.angle < $1.angle})
print(polarCoordinates.count)
//let test = atan2(Double(2) , Double(0))

// this will assume my monitoring station to be in 0,0 and will return the value in radiants given the position of each asteroid relative to my monitoring station y axis pointing down but starting with origin vector pointing up and going clockwise!
func convert(x: Double ,y: Double) -> Double {
        let degreesToRadians = Double(CGFloat.pi / 180)
        let angle = (-atan2(-y,x) + degreesToRadians * 90)
        if angle < 0 {
            return angle + 360 * degreesToRadians
        }
        return angle
}


var x: Double = 5.0
var y: Double = 0.0
print("\n\ntest\n")
print("atan for x \(x) ,y \(y) is \(convert(x: x, y: y)) ")
 x  = 2.0
 y = -2.0
print("atan for x \(x) ,y \(y) is \(convert(x: x, y: y))   ")
 x  = 0.01
 y = -5.0
print("atan for x \(x) ,y \(y) is \(convert(x: x, y: y))   ")
 x  = -0.01
 y = -5.0
print("atan for x \(x) ,y \(y) is \(convert(x: x, y: y))   ")
 x  = 0
 y = 5.0
print("atan for x \(x) ,y \(y) is \(convert(x: x, y: y)) ")
