
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
