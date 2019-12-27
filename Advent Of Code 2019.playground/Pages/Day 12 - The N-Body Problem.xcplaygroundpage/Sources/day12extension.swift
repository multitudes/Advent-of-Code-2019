import Foundation


public struct Moon {
    public var name: String
    public var position: [Int] = [Int]()
    public var velocity: [Int] = [0,0,0]
    lazy public var potentialEnergy = position.compactMap { abs($0) }.reduce(0, +)
    lazy public var kineticEnergy = velocity.compactMap { abs($0) }.reduce(0, +)
    lazy public var moonTotalEnergy = potentialEnergy * kineticEnergy
    public init(name: String, position:[Int]) {
       self.position = position
        self.name = name
    }
    public mutating func setVelocity(_ newvelocity: [Int]) {
        self.velocity = newvelocity
    }
    public mutating func updatePosition() {
        let newPosition = zip(self.position, self.velocity).map(+)
        print(newPosition)
        self.position = newPosition
    }
}

public struct Jupyter {
    public var moons = [Moon]()
    public var originalPosition = [[Int]]()
    // this init takes the positions of all the moons as in the input file and create the array of moons
    public init(positions: [[Int]], names: [String]) {
        for i in 0..<positions.count {
            let moon = Moon(name: names[i], position: positions[i])
            self.originalPosition = positions
            self.moons.append(moon)
        }
        //print("originalPosition \(originalPosition)")
    }

    public mutating func getTotalEnergy() -> Int {
        var totalEnergy = 0
        for i in 0..<moons.count  {
            print(moons[i].potentialEnergy)
            print(moons[i].kineticEnergy)
            totalEnergy += moons[i].moonTotalEnergy
        }
        return totalEnergy
    }
    public mutating func step() {
        //calculateVelocity. Repeating for the number of moons = 4 times
        for _ in 0..<moons.count {
            // because I use structs I remove the first element of the array and append at the end to get the updated array
            var moon = self.moons.removeFirst()
            // this is to crucial debug if I was doing it right!
            //print("position \(moon.position)")
            //print("velocity : \(moon.velocity)")
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
            //print("new velocity : \(newVelocity)")
        }
        // now need to again update the position adding the old position with velocity
        for _ in 0..<moons.count {
            var moon = self.moons.removeFirst()
            let newPosition = zip(moon.position, moon.velocity).map(+)
            //print("\nnew calculated position: \(newPosition)")
            moon.position = newPosition
            self.moons.append(moon)
        }
     }
    
    public mutating func runNumberOf(steps: Int) {
        for _ in 0..<steps  {
            self.step()
        }
        print("\n\nPart one solution! Total Energy after \(steps) steps is \(getTotalEnergy())\n")
    }

    public mutating func stepPerDimension(axis: Int) -> Int {
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
        //print("initialized!")
        //print(positionPerDimension)
        //print(velocityPerDimension)
        // save the beginning state
        let origPositionPerDimension = positionPerDimension
        let origVelocityPerDimension = velocityPerDimension
        var number = 0
        repeat {
            (number += 1)
            for i in 0..<moonCount{
                for j in 1..<moonCount {
                    let k = (i + j) % moonCount
                    if (positionPerDimension[i]! > positionPerDimension[k]!) {
                        (velocityPerDimension[i]! -= 1)
                    } else if (positionPerDimension[i]! < positionPerDimension[k]!) {
                        (velocityPerDimension[i]! += 1)
                    }
                }
            }
            //print("old position \(positionPerDimension) merging \(velocityPerDimension)")
            positionPerDimension.merge(velocityPerDimension, uniquingKeysWith: +)
            //print("new position \(positionPerDimension)")
            
        } while (positionPerDimension != origPositionPerDimension) || (origVelocityPerDimension != velocityPerDimension)
        print("axis \(axis) has : \(number) steps.")
        return number
    }
    
                
}
extension Moon: CustomStringConvertible {
  //This is a computed property.
    public var description: String {
        let text = "name: \(name) position \(position) velocity \(velocity)"
        return text
    }
}

public func gcd(_ m: Int, _ n: Int) -> Int {
    let r: Int = m % n
    if r != 0 {
        return gcd(n, r)
    } else {
        return n
    }
}

public func gcd(_ numbers: Int...) -> Int {
    gcd(numbers)
}

public func gcd(_ numbers: [Int]) -> Int {
    numbers.reduce(0) { gcd($0, $1) }
}

public func lcm(_ m: Int, _ n: Int) -> Int {
    m / gcd(m, n) * n
}

public func lcm(_ numbers: Int...) -> Int {
    lcm(numbers)
}

public func lcm(_ numbers: [Int]) -> Int {
    numbers.reduce(numbers[0]) { lcm($0, $1) }
}


//extension Moon: CustomStringConvertible {
//  //This is a computed property.
//    var description: String {
//        var text = "name: \(name) position \(position) velocity \(velocity)"
//        return text
//    }
//}
    // this will search for the object name and return the object or one of its children
//    public func search(name: String) -> SpaceObject? {
//        if name == self.name {
//            return self
//        }
//        for orbitingObject in orbitingObjects {
//            if let found = orbitingObject.search(name: name) {
//            return found
//            }
//            }
//        return nil
//    }


//public class Moon : Hashable {
//    public var name: String
//    public var orbitingObjects:[SpaceObject] = []
//    public weak var parentObject: SpaceObject? // this is the parent. not every object got a parent. weak to avoid retain cycles.
//    public init(name: String) {
//        self.name = name
//    }
//    public func add(orbitingObject: SpaceObject) {
//        orbitingObjects.append(orbitingObject)
//        orbitingObject.parentObject = self //once I add an orbiting object (child) then I become a center object (parent) of the child
//    }
//    // this is tricking swift to make sets of spaceobjects. The class needs to conform to hashable and equatable.
//    public static func == (lhs: SpaceObject, rhs: SpaceObject) -> Bool {
//        return lhs.name == rhs.name
//    }
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(name)
//    }
//}
