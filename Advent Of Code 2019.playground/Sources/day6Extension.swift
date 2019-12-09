
extension SpaceObject: CustomStringConvertible {
  //This is a computed property. Mapping will be recursive!
    public var description: String {
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

public class SpaceObject : Hashable {
    public var value: String
    public var orbitingObjects:[SpaceObject] = []
    public weak var parentObject: SpaceObject? // this is the parent. not every object got a parent. weak to avoid retain cycles.
    public init(value: String) {
        self.value = value
    }
    public func add(orbitingObject: SpaceObject) {
        orbitingObjects.append(orbitingObject)
        orbitingObject.parentObject = self //once I add an orbiting object (child) then I become a center object (parent) of the child
    }
    // this is tricking swift to make sets of spaceobjects. The class needs to conform to hashable and equatable.
    public static func == (lhs: SpaceObject, rhs: SpaceObject) -> Bool {
        return lhs.value == rhs.value
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
