//: [Previous](@previous)
/*:
# Day 6: Universal Orbit Map

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
You've landed at the Universal Orbit Map facility on Mercury. Because navigation in space often involves transferring between orbits, the orbit maps here are useful for finding efficient routes between, for example, you and Santa. You download a map of the local orbits (your puzzle input).

Except for the universal Center of Mass (COM), every object in space is in orbit around exactly one other object. An orbit looks roughly like this:
```
                  \
                   \
                    |
                    |
AAA--> o            o <--BBB
                    |
                    |
                   /
                  /
```

 In this diagram, the object BBB is in orbit around AAA. The path that BBB takes around AAA (drawn with lines) is only partly shown. In the map data, this orbital relationship is written AAA)BBB, which means "BBB is in orbit around AAA".

Before you use your map data to plot a course, you need to make sure it wasn't corrupted during the download. To verify maps, the Universal Orbit Map facility uses orbit count checksums - the total number of direct orbits (like the one shown above) and indirect orbits.

Whenever A orbits B and B orbits C, then A indirectly orbits C. This chain can be any number of objects long: if A orbits B, B orbits C, and C orbits D, then A indirectly orbits D.

For example, suppose you have the following map:

COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L

 Visually, the above map of orbits looks like this:
```
        G - H       J - K - L
       /           /
COM - B - C - D - E - F
               \
                I
```
 
 In this visual representation, when two objects are connected by a line, the one on the right directly orbits the one on the left.

Here, we can count the total number of orbits as follows:

D directly orbits C and indirectly orbits B and COM, a total of 3 orbits.
L directly orbits K and indirectly orbits J, E, D, C, B, and COM, a total of 7 orbits.
COM orbits nothing.
The total number of direct and indirect orbits in this example is 42.

What is the total number of direct and indirect orbits in your map data?

Your puzzle answer was 245089.

--- Part Two ---

Now, you just need to figure out how many orbital transfers you (YOU) need to take to get to Santa (SAN).

You start at the object YOU are orbiting; your destination is the object SAN is orbiting. An orbital transfer lets you move from any object to an object orbiting or orbited by that object.

For example, suppose you have the following map:

COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN
Visually, the above map of orbits looks like this:

 ```
                          YOU
                         /
        G - H       J - K - L
       /           /
COM - B - C - D - E - F
               \
                I - SAN
```
 In this example, YOU are in orbit around K, and SAN is in orbit around I. To move from K to I, a minimum of 4 orbital transfers are required:

K to J
J to E
E to D
D to I
Afterward, the map of orbits looks like this:
```
        G - H       J - K - L
       /           /
COM - B - C - D - E - F
               \
                I - SAN
                 \
                  YOU
```
 What is the minimum number of orbital transfers required to move from the object YOU are orbiting to the object SAN is orbiting? (Between the objects they are orbiting - not between YOU and SAN.)


: [Next](@next)
*/

import Foundation
// func getInput is in utilities file
var input = getInput(inputFile: "input6", extension: "txt")
//get the input file as an array into program
var map = input.components(separatedBy: "\n").filter { $0 != "" }

// class SpaceObject is in separate file. Class contains properties collecting the parent and children of instance
extension SpaceObject: CustomStringConvertible {
  //This is a computed property. Mapping will be recursive!
    public var description: String {
        var text = "\(name)"
        if !orbitingObjects.isEmpty {
          text += " {" + orbitingObjects.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
    // this will search for the object name and return the object or one of its children
    public func search(name: String) -> SpaceObject? {
        if name == self.name {
            return self
        }
        for orbitingObject in orbitingObjects {
            if let found = orbitingObject.search(name: name) {
            return found
            }
            }
        return nil
    }

}

public class SpaceObject : Hashable {
    public var name: String
    public var orbitingObjects:[SpaceObject] = []
    public weak var parentObject: SpaceObject? // this is the parent. not every object got a parent. weak to avoid retain cycles.
    public init(name: String) {
        self.name = name
    }
    public func add(orbitingObject: SpaceObject) {
        orbitingObjects.append(orbitingObject)
        orbitingObject.parentObject = self //once I add an orbiting object (child) then I become a center object (parent) of the child
    }
    // this is tricking swift to make sets of spaceobjects. The class needs to conform to hashable and equatable.
    public static func == (lhs: SpaceObject, rhs: SpaceObject) -> Bool {
        return lhs.name == rhs.name
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
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
print("Solution Day 6 part 1 is : \(count)")


/*:
### Day 6: Universal Orbit Map part 2
*/

func minNumTransfers(allOrbitingObj: [String : SpaceObject], from: String, to: String) -> Int {
    var commonParents: [SpaceObject] = []
    allOrbitingObj.forEach { spaceObject in
        if spaceObject.value.search(name: "YOU") != nil && spaceObject.value.search(name: "SAN") != nil {
                commonParents.append(spaceObject.value)
        }
    }
    let minOrbits: Int = commonParents.map {
        countOrbits(spaceObject: $0, child: allOrbitingObj[from]!) + countOrbits(spaceObject: $0, child: allOrbitingObj[to]!)
    }.min()!
    print("Solution Day 6 part 2 is \(minOrbits)")
    return 0
}

func countOrbits(spaceObject: SpaceObject, child: SpaceObject) -> Int {
    var count = 0
    if let a = child.parentObject  {
        if a != spaceObject {
        count = 1 + countOrbits(spaceObject: spaceObject, child: a)
        }
    }
    return count
}

// this call will give the solution to part 2
minNumTransfers(allOrbitingObj: allOrbitingObj, from: "YOU", to: "SAN")
