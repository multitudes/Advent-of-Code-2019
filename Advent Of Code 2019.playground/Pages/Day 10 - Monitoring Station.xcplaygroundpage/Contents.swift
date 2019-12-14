
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
    
    init(asteroidMap: [String]) {
        self.asteroidMap = asteroidMap
        self.setMonitorinStation()
    }
    
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

//
//
//var polarCoordinates:[(radius: Double, angle :Double)] = []
//func getRadius(_ a: Double, _ b: Double) -> Double {
//    return (a * a + b * b).squareRoot()
//}
//
//
////polarCoordinates.sort(by: {$0.angle < $1.angle})
////print(polarCoordinates.count)
////let test = atan2(Double(2) , Double(0))
//
//// this will assume my monitoring station to be in 0,0 and will return the value in radiants given the position of each asteroid relative to my monitoring station y axis pointing down but starting with origin vector pointing up and going clockwise!
//func convertToPolar(x: Double ,y: Double) -> (Double, Double) {
//    let radius: Double = getRadius(x, y)
//    let degreesToRadians = Double(CGFloat.pi / 180)
//        var angle = (-atan2(-y,x) + degreesToRadians * 90)
//        if angle < 0 {
//            angle = angle + 360 * degreesToRadians
//            return (angle, radius)
//        }
//        return (angle, radius)
//}
//
//// this was to test the polar coordinates
//var x: Double = 5.0
//var y: Double = 0.0
//print("\n\ntest\n")
//print("atan for x \(x) ,y \(y) is \(convertToPolar(x: x, y: y)) ")
// x  = 2.0
// y = -2.0
//print("atan for x \(x) ,y \(y) is \(convertToPolar(x: x, y: y))   ")
// x  = 0.01
// y = -5.0
//print("atan for x \(x) ,y \(y) is \(convertToPolar(x: x, y: y))   ")
// x  = -0.01
// y = -5.0
//print("atan for x \(x) ,y \(y) is \(convertToPolar(x: x, y: y))   ")
// x  = 0
// y = 5.0
//print("atan for x \(x) ,y \(y) is \(convertToPolar(x: x, y: y)) ")
