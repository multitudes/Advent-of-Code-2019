//: [Previous](@previous)
/*:
# Day 3: Crossed Wires

[See it on github](https://github.com/multitudes/Advent-of-Code-2019)
 Opening the front panel reveals a jumble of wires. Specifically, two wires are connected to a central port and extend outward on a grid. You trace the path each wire takes as it leaves the central port, one wire per line of text (your puzzle input).What is the Manhattan distance from the central port to the closest intersection?
 &nbsp;

[Next >](@next)
*/
import UIKit

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
let commonElements = Array(Set(bluePath).intersection(Set(redPath)))
// The manhattan distance is the sum of the abs of coordinates. I look for the smallest
let manhattan = commonElements.compactMap { abs($0.x) + abs($0.y) }.min()
print("the answer is : \(manhattan!)")
// manhattan = 5319
