

import Foundation

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
