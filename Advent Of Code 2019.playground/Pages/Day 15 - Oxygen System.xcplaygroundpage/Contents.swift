//: [Previous](@previous)
/*:
# Day 15: Oxygen System

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   

 Out here in deep space, many things can go wrong. Fortunately, many of those things have indicator lights. Unfortunately, one of those lights is lit: the oxygen system for part of the ship has failed!

 According to the readouts, the oxygen system must have failed days ago after a rupture in oxygen tank two; that section of the ship was automatically sealed once oxygen levels went dangerously low. A single remotely-operated repair droid is your only option for fixing the oxygen system.

 The Elves' care package included an Intcode program (your puzzle input) that you can use to remotely control the repair droid. By running that program, you can direct the repair droid to the oxygen system and fix the problem.

 The remote control program executes the following steps in a loop forever:

 Accept a movement command via an input instruction.
 Send the movement command to the repair droid.
 Wait for the repair droid to finish the movement operation.
 Report on the status of the repair droid via an output instruction.
 Only four movement commands are understood: north (1), south (2), west (3), and east (4). Any other command is invalid. The movements differ in direction, but not in distance: in a long enough east-west hallway, a series of commands like 4,4,4,4,3,3,3,3 would leave the repair droid back where it started.

 The repair droid can reply with any of the following status codes:

 0: The repair droid hit a wall. Its position has not changed.
 1: The repair droid has moved one step in the requested direction.
 2: The repair droid has moved one step in the requested direction; its new position is the location of the oxygen system.

 [...]

 ## Part 2
 
: [Next](@next)
*/

import Foundation


// func getInput is in utilities file
var input = getInput(inputFile: "input15", extension: "txt")
//get the input file as an array into program
var inputProgramArray = input.components(separatedBy: ",").compactMap { Int($0) }

var program = Dictionary(uniqueKeysWithValues: zip(0..., inputProgramArray))




public class IntCodeComputer {
    public var instructionPointer = 0
    public var relativeBase = 0
    public var outputs = [Int]()
    public var program: [Int:Int]
    public var output: [Int] = []
    
    public init(program: [Int:Int]) {
        self.instructionPointer = 0
        self.outputs = []
        self.program = program
    }

    public func run() -> [Int] {
    // the instructionPointer will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
    //while outputs.count != 1 {
        while program[instructionPointer] != 99 {
        if instructionPointer <= 0 { instructionPointer = 0 }
        if program[instructionPointer]! / 10000 > 3 {
            print("\n error opcode =================\n ")
            break}
        // func createInstruction is in utilities file and returns an instance of the Instruction struct
        let instruction = createInstruction(program: program , instructionPointer: instructionPointer, relativeBase: relativeBase)
        switch instruction.opcode {
            case .add:
                program[instruction.parameters[2]] = instruction.parameters[0] + instruction.parameters[1]
                instructionPointer += 4
            case .multiply:
                program[instruction.parameters[2]] = instruction.parameters[0] * instruction.parameters[1]
                instructionPointer += 4
            case .input:
                //print("\n TEST Input: 2 ")
                // readLine does not work in Playgrounds 😅 I will hardcode it
               
                instructionPointer += 2
            case .output:
   
                 instructionPointer += 2
            case .jumpIfTrue:
                if instruction.parameters[0] != 0 {
                    instructionPointer = instruction.parameters[1]
                    } else {
                    instructionPointer += 3
               }
            case .jumpIfFalse:
                if instruction.parameters[0] == 0 {
                    instructionPointer = instruction.parameters[1]
                    continue
                    } else {
                    instructionPointer += 3
                }
            case .lessThan:
                if instruction.parameters[0] < instruction.parameters[1] {
                    program[instruction.parameters[2]] = 1 } else {
                    program[instruction.parameters[2]] = 0
                }
                instructionPointer += 4
            case  .equals:
                if instruction.parameters[0] == instruction.parameters[1] {
                    program[instruction.parameters[2]] = 1 } else {
                    program[instruction.parameters[2]] = 0
                }
                instructionPointer += 4
            case .relativeBaseOffset:
                relativeBase += instruction.parameters[0]
                instructionPointer += 2
            case .halt:
                print("stop")
            }
        }
        return [0]
    }
    
    public func createInstruction(program: [Int: Int], instructionPointer: Int, relativeBase: Int) -> Instruction {
        let opcode: Opcode = Opcode(rawValue: program[instructionPointer]! % 100)!
        let modes = [ Mode(rawValue: program[instructionPointer]! % 1000 / 100)!, Mode(rawValue: program[instructionPointer]! % 10000 / 1000)! , Mode(rawValue: program[instructionPointer]! / 10000)!]
        var firstParam: Int = 0; var secondParam: Int = 0; var thirdParam: Int = 0; var parameters: [Int] = []
        switch opcode {
        case .add, .multiply, .equals, .lessThan:
                if modes[0] == .position {
                    if let a = program[instructionPointer + 1] {
                        if let b = program[a] { firstParam = b } else { firstParam = 0 }}}
                else if modes[0] == .relative {
                    if let a = program[instructionPointer + 1] {
                        if let b = program[a + relativeBase] { firstParam = b } else { firstParam = 0 }}}
                else {
                    firstParam = program[instructionPointer + 1] ?? 0
                    }
                if modes[1] == .position {
                    if let a = program[instructionPointer + 2] {
                        if let b = program[a] { secondParam = b } else { secondParam = 0 }}}
                else if modes[1] == .relative {
                    if let a = program[instructionPointer + 2] {
                        if let b = program[a + relativeBase] { secondParam = b } else { secondParam = 0 }}}
                else {
                    secondParam = program[instructionPointer + 2] ?? 0
                }
                if modes[2] == .position {
                    if let a = program[instructionPointer + 3] {
                        thirdParam = a }}
                else if modes[2] == .relative {
                    if let a = program[instructionPointer + 3] {
                            thirdParam = a + relativeBase }}
                else {
                    print("\n\nerror write cannot have immediate mode 1 \n\n")
                }
                parameters = [firstParam, secondParam, thirdParam]
            
            case .input:
                if modes[0] == .position {
                        if let a = program[instructionPointer + 1] {
                            firstParam = a }}
                else if modes[0] == .relative {
                        if let a = program[instructionPointer + 1] {
                            firstParam = a + relativeBase }}
                    else {
                        print("\n\nerror write cannot have immediate mode 1 \n\n")
                }
                parameters = [firstParam]
            case .output:
                if modes[0] == .position {
                        if let a = program[instructionPointer + 1] {
                            if let b = program[a] { firstParam = b }  else { firstParam = 0 }}}
                else if modes[0] == .relative {
                        if let a = program[instructionPointer + 1] {
                            if let b = program[a + relativeBase] {
                                firstParam = b }
                            else { firstParam =  0 }}}
                    else {
                        firstParam = program[instructionPointer + 1] ?? 0
                }
                parameters = [firstParam]
            
            case .jumpIfTrue, .jumpIfFalse:
                if modes[0] == .position {
                    if let a = program[instructionPointer + 1] {
                        if let b = program[a] { firstParam = b } else { firstParam = 0 }}}
                else if modes[0] == .relative {
                    if let a = program[instructionPointer + 1] {
                        if let b = program[a + relativeBase] { firstParam = b } else { firstParam = 0 }}}
                else {
                    firstParam = program[instructionPointer + 1] ?? 0
                    }
                if modes[1] == .position {
                    if let a = program[instructionPointer + 2] {
                        if let b = program[a] { secondParam = b } else { secondParam = 0 }}}
                else if modes[1] == .relative {
                    if let a = program[instructionPointer + 2] {
                        if let b = program[a + relativeBase] { secondParam = b } else { secondParam = 0 }}}
                else {
                    secondParam = program[instructionPointer + 2] ?? 0
                }
                parameters = [firstParam, secondParam]

            
            case .relativeBaseOffset:
                if modes[0] == .position {
                        if let a = program[instructionPointer + 1] {
                            if let b = program[a] { firstParam = b } else { firstParam = 0 }}}
                else if modes[0] == .relative {
                        if let a = program[instructionPointer + 1] {
                            if let b = program[a + relativeBase] { firstParam = b } else { firstParam = 0 }}}
                    else {
                        firstParam = program[instructionPointer + 1] ?? 0
                }
                parameters = [firstParam]
            
            case .halt:
                print("stop")
        }
        return Instruction(opcode: opcode, parameters: parameters ,modes: modes)
    }
}

// Possible opcodes
public enum Opcode: Int {
    case add = 1,
        multiply = 2,
        input = 3,
        output = 4,
        jumpIfTrue = 5,
        jumpIfFalse = 6,
        lessThan = 7,
        equals = 8,
        relativeBaseOffset = 9,
        halt = 99
}
// Possible modes for a parameter
public enum Mode: Int {
    case position = 0,
        immediate = 1,
        relative = 2

}
// the instruction will be ABCDE the last two digit the opcodes and the rest parameters
public struct Instruction {
    public let opcode: Opcode
    public var parameters: [Int]
    public var modes: [Mode]
}

public class Maze {
    public var board: [Coordinate: Node]
    public var currentNode: Node
    public var movingDirection: Direction = .north
    // init the board will have only one known node which is the currentNode at zero coordinate
    public init(){
        self.currentNode = Node(coordinates: .zero, distance: 0, nodeType: .path)
        self.board = [.zero: currentNode]
        }
    // the function move will be on my computer input
    public func move() -> Int {
        // check if my move is going to an already known node
        movingDirection = self.currentNode.freeDirections.randomElement() ?? .north
        
        return movingDirection.rawValue
    }
    // the function move will take my computer output and modify the maze accordingly
    public func updateMove(with output: Int){
        let nodeType = NodeType(rawValue: output)
        switch nodeType {
            case .wall :
                // if this is a wall as response to my move then I update my current node and add
                // the wall as visited node
                let removed = self.currentNode.freeDirections.remove(movingDirection)
                // add the wall to the board
                let newCoordinates = updateCoordinateFrom(direction: movingDirection)
                    //Coordinate(x: 0, y: 0)
                let nextNode = Node(coordinates: newCoordinates, distance: (currentNode.distance + 1), nodeType: .wall)
                self.board[newCoordinates] = nextNode
                print("removed \(removed!)")
            case .path:
                let newCoordinates = updateCoordinateFrom(direction: movingDirection)
                    //Coordinate(x: 0, y: 0)
                let nextNode = Node(coordinates: newCoordinates, distance: (currentNode.distance + 1), nodeType: .path)
                self.board[newCoordinates] = nextNode
                self.currentNode = nextNode
                print("moved \(movingDirection)!")
            case .oxygen:
                print("bingo")
                print("distance \(self.currentNode.distance + 1)")
                let newCoordinates = updateCoordinateFrom(direction: movingDirection)
                    //Coordinate(x: 0, y: 0)
                let nextNode = Node(coordinates: newCoordinates, distance: (currentNode.distance + 1), nodeType: .oxygen)
                self.board[newCoordinates] = nextNode
                self.currentNode = nextNode
                default :
            print("nothing")
        }
        
    }
    public func updateCoordinateFrom(direction: Direction) -> Coordinate{
        let newCoordinates : Coordinate
        switch direction {
            case .north:
                newCoordinates = Coordinate(x: (self.currentNode.coordinates.x), y: self.currentNode.coordinates.y - 1)
            case .south:
                newCoordinates = Coordinate(x: (self.currentNode.coordinates.x), y: self.currentNode.coordinates.y + 1)
            case .west:
                newCoordinates = Coordinate(x: (self.currentNode.coordinates.x + 1), y: self.currentNode.coordinates.y )
            case .east:
                newCoordinates = Coordinate(x: (self.currentNode.coordinates.x - 1), y: self.currentNode.coordinates.y)
        }
        return newCoordinates
    }
//    func candidates(for position: Coordinate, on board: [Coordinate: NodeType]) -> [tuple] {
//        return [
//            board[position + north.vector] == nil ? north : nil,
//            board[position + south.vector] == nil ? south : nil,
//            board[position + west.vector] == nil ? west : nil,
//            board[position + east.vector] == nil ? east : nil,
//            ].compactMap { $0 }
//    }
}
public struct Node {
    public let coordinates: Coordinate
    public var distance: Int
    public var nodeType: NodeType
    public var freeDirections: Set<Direction> = [.north, .south, .west, .east]
    public init(coordinates: Coordinate, distance: Int, nodeType: NodeType){
        self.coordinates = coordinates
        self.distance = distance
        self.nodeType = nodeType
    }
}

public enum NodeType: Int {
    case wall = 0
    case path
    case oxygen
    case unknown
}

public enum Direction: Int {
    //MARK: Hashable
    public var hashValue: Int {
              return rawValue.hashValue
    }
    case north = 1
    case south = 2
    case west = 3
    case east = 4
}

public struct Coordinate: Hashable {
    public let x: Int
    public let y: Int
    public init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
    public static let zero = Coordinate(x: 0, y: 0)
}

var maze = Maze()
var direction = maze.move()
print(direction)
direction = maze.move()
maze.updateMove(with: 1)
direction = maze.move()
maze.updateMove(with: 1)
direction = maze.move()
maze.updateMove(with: 0)
maze.updateMove(with: 2)

print(maze.currentNode.freeDirections)
print(maze.board)




extension Direction: CustomStringConvertible {
  //This is a computed property.
    public var description: String {
        switch self {
            case .north:
            return "north"
            case .south:
             return "south"
            case .west:
             return "west"
            case .east:
             return "east"
        }
    }
}
extension NodeType: CustomStringConvertible {
  //This is a computed property.
    public var description: String {
        switch self {
            case .wall:
            return "wall"
            case .path:
             return "path"
            case .oxygen:
             return "oxygen"
            case .unknown:
            return "unknown"
        }
    }
}
extension Coordinate: CustomStringConvertible {
  //This is a computed property.
    public var description: String {
        let text = "x: \(x) y: \(y) "
        return text
    }
}

extension Maze: CustomStringConvertible {
  //This is a computed property.
    public var description: String {
        let text = "board nodes: \(board) current position  \(currentNode) moving to  \(movingDirection)"
        return text
    }
}

extension Collection where Element: Comparable {
    public func range() -> ClosedRange<Element> {
        precondition(count > 0)
        let sorted = self.sorted()
        return sorted.first! ... sorted.last!
    }
}

extension Dictionary where Key == Coordinate {
    public var xRange: ClosedRange<Int> { keys.map { $0.x }.range() }
    public var yRange: ClosedRange<Int> { keys.map { $0.y }.range() }
}
