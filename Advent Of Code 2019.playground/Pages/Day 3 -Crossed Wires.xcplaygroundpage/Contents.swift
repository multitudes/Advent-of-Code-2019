//: [Previous](@previous)
/*:
# Day 3: Crossed Wires

[See it on github](https://github.com/multitudes/Advent-of-Code-2019)
 
 The gravity assist was successful, and you're well on your way to the Venus refuelling station. During the rush back on Earth, the fuel management system wasn't completely installed, so that's next on the priority list.

 Opening the front panel reveals a jumble of wires. Specifically, two wires are connected to a central port and extend outward on a grid. You trace the path each wire takes as it leaves the central port, one wire per line of text (your puzzle input).

 The wires twist and turn, but the two wires occasionally cross paths. To fix the circuit, you need to find the intersection point closest to the central port. Because the wires are on a grid, use the Manhattan distance for this measurement. While the wires do technically cross right at the central port where they both start, this point does not count, nor does a wire count as crossing with itself.

 For example, if the first wire's path is R8,U5,L5,D3, then starting from the central port (o), it goes right 8, up 5, left 5, and finally down 3:

 ```
 ...........
 ...........
 ...........
 ....+----+.
 ....|....|.
 ....|....|.
 ....|....|.
 .........|.
 .o-------+.
 ...........

 ```
 
 Then, if the second wire's path is U7,R6,D4,L4, it goes up 7, right 6, down 4, and left 4:
 
```
 ...........
 .+-----+...
 .|.....|...
 .|..+--X-+.
 .|..|..|.|.
 .|.-X--+.|.
 .|..|....|.
 .|.......|.
 .o-------+.
 ...........
 
 ```
 
 These wires cross at two locations (marked X), but the lower-left one is closer to the central port: its distance is 3 + 3 = 6.

 Here are a few more examples:

 - R75,D30,R83,U83,L12,D49,R71,U7,L72
 U62,R66,U55,R34,D71,R55,D58,R83 = distance 159
 - R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
 U98,R91,D20,R16,D67,R40,U7,R15,U6,R7 = distance 135
 
 What is the Manhattan distance from the central port to the closest intersection?

 Your puzzle answer was 5319.

 --- Part Two ---

 It turns out that this circuit is very timing-sensitive; you actually need to minimize the signal delay.

 To do this, calculate the number of steps each wire takes to reach each intersection; choose the intersection where the sum of both wires' steps is lowest. If a wire visits a position on the grid multiple times, use the steps value from the first time it visits that position when calculating the total value of a specific intersection.

 The number of steps a wire takes is the total number of grid squares the wire has entered to get to that location, including the intersection being considered. Again consider the example from above:&#10;

 ```
 ...........
 .+-----+...
 .|.....|...
 .|..+--X-+.
 .|..|..|.|.
 .|.-X--+.|.
 .|..|....|.
 .|.......|.
 .o-------+.
 ...........
 ```
 
 In the above example, the intersection closest to the central port is reached after 8+5+5+2 = 20 steps by the first wire and 7+6+4+3 = 20 steps by the second wire for a total of 20+20 = 40 steps.

 However, the top-right intersection is better: the first wire takes only 8+5+2 = 15 and the second wire takes only 7+6+2 = 15, a total of 15+15 = 30 steps.

 Here are the best steps for the extra examples from above:

 - R75,D30,R83,U83,L12,D49,R71,U7,L72
 U62,R66,U55,R34,D71,R55,D58,R83 = 610 steps
 - R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
 U98,R91,D20,R16,D67,R40,U7,R15,U6,R7 = 410 steps
 
 What is the fewest combined steps the wires must take to reach an intersection?

 Your puzzle answer was 122514.


 &nbsp;

[Next >](@next)
*/
import Foundation

// declaring the var containing the input
var input = ""
// I want to convert the input from an array of strings to an array of tuples: ("L", 627), ("U", 273), ("R", 226),..
var redWire: [(String, Int)]
var blueWire: [(String, Int)]

// this will look in my resources folder for the input.txt file
do {
    guard let fileUrl = Bundle.main.url(forResource: "input3", withExtension: "txt") else { fatalError() }
    input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
    //print("input is: \(input)")
} catch {
    print(error)
}
//get the input file as wire which is two arrays of Strings
var wires = input.components(separatedBy: "\n")
// declare wireTuples as two array of tuples
var wireTuples: [[(String, Int)]] = [[("",0)],[("",0)]]
// loop twice because wires is the input split in two chunks wires[0] and wires[1]
//wiretuple also will be in two chunks wireTuple[0] and wireTuple[0] which will be each an array of tuples
// and assigned to redWire and blueWire
for i in 0..<2 {
let wire = wires[i].components(separatedBy: ",") // get two arrays of [String] like ["D323",...]
    // get two arrays of tuples wireTuples[0] is
wireTuples[i] = wire.map {  (str: String) -> (String, Int) in
                            let firstIndex = str.startIndex 
                            let a = str[firstIndex]
                            let secondIndex = str.index(after: str.startIndex)
                            let lastIndex = str.endIndex
                            let range = secondIndex..<lastIndex
                            let b = Int(str[range])
                            return  (String(a), b ?? 0)}
                            }
// got my two wires - the tuples are like ("U", 732), ("L", 444)
redWire = wireTuples[0]
blueWire = wireTuples[1]

// From each Tuple in redWire and BlueWire I create arrays of points containing the coordinates
// and will see where they cross
// initialise the array of coordinates - coordinates are x and y values in a struct called Point declared in sources folder
var redPath:[Point] = []
var bluePath:[Point] = []

// fill the coordinates array with the instructions in the wire array - function drawpath is in the playground included
// in the sources folder. Arrays are struct and passed by value in Swift so I need to pass by reference
drawPath(path: &redPath, wire: redWire)
drawPath(path: &bluePath, wire: blueWire)
// convert the array to set and get the intersection
var commonElements = Array(Set(bluePath).intersection(Set(redPath)))
// The manhattan distance is the sum of the abs of coordinates. I look for the smallest
let manhattan = commonElements.compactMap { abs($0.x) + abs($0.y) }.min()
print("the solution to part 1 the Manhattan distance is : \(manhattan!)")
// manhattan = 5319

// part two

// this dictionary holds for every point the number of steps
var steps = [Point: Int]()
 

//I create two dictionaries for both wires
var blueSteps = [Point: Int]()
var redSteps = [Point: Int]()

 // I loop over the commonElements putting the index of redPath and bluePath as value for the points found to intersect
commonElements.forEach {
    blueSteps[$0] = bluePath.firstIndex(of: $0)
    redSteps[$0] = redPath.firstIndex(of: $0)
    // this is a dic which for every point in the intersection will store the sum of the steps of both wires
    steps[$0] = blueSteps[$0]! + redSteps[$0]!
 }
// just need to find the min value of the dictionary
let fewestSteps = steps.min { $0.value < $1.value }
// solution is plus two because I start counting steps for both redPath and bluePath from 0 so the counts are already 1 less
// adding both I am two steps short which I add at the end
let solution = fewestSteps!.value + 2
print("the solution to part 2 is : \(solution)")
//  122514!
