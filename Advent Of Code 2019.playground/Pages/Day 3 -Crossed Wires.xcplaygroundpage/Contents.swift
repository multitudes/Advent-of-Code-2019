//: [Previous](@previous)
/*:
# Day 3: Crossed Wires
###            --- Part Two ---
[See it on github](https://github.com/multitudes/Advent-of-Code-2019)
 Opening the front panel reveals a jumble of wires. Specifically, two wires are connected to a central port and extend outward on a grid. You trace the path each wire takes as it leaves the central port, one wire per line of text (your puzzle input).What is the Manhattan distance from the central port to the closest intersection?
 &nbsp;

[Next >](@next)
*/
import UIKit



// declaring the var containing the input
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
                            let firstIndex = str.index(str.startIndex, offsetBy: 0)
                            let a = str[firstIndex]
                            let secondIndex = str.index(after: str.startIndex)
                            let lastIndex = str.index(str.endIndex, offsetBy: 0)
                            let range = secondIndex..<lastIndex
                            let b = Int(str[range])
                            return  (String(a), b ?? 0)}
                            }
redWire = wireTuples[0]
blueWire = wireTuples[1]
//print(redWire)
//print(blueWire)

// now need to imagine to plot the arrays
// From each Tuple in redWire and BlueWire I create arrays of tuples containing the coordinates and sill see where they cross
// initialise the array of coordinates - coordinates are a tuple x and y
var redPath:[Point] = []
var bluePath:[Point] = []

//var redPath:[(x: Int, y: Int)] = []
//var bluePath:[(x: Int, y: Int)] = []
// fill the coordinates array with the instructions in the wire array - function drawpath is in the playground included
drawPath(path: &redPath, wire: redWire)
drawPath(path: &bluePath, wire: blueWire)


print(bluePath)

// find the common points


extension Array  {
    func contains<E1, E2>(_ tuple: (E1, E2)) -> Bool where E1: Equatable, E2: Equatable, Element == (x: E1, y: E2) {
        return contains { $0.0 == tuple.0 && $0.1 == tuple.1 }
    }
}
extension Array  {
    func contains<E1, E2>(_ tuple: (E1, E2)) -> Bool where E1: Hashable, E2: Hashable, Element == (x: E1, y: E2) {
        return contains { $0.0 == tuple.0 && $0.1 == tuple.1 }
    }
}

//You can use the filter method to return all elements of findList which are not in list:
let a = [(1, "a"), (2, "b")]
//print(a.contains((1, "a")))

//var intersections = bluePath.contains((x: 5177, y: -7313))
//var intersections = bluePath.filter( { redPath.contains($0) == true } )


let commonElements = Array(Set(bluePath).intersection(Set(redPath)))
let manhattan = commonElements.map { abs($0.x) + abs($0.y) }.min()
print(manhattan!)
