//: [Previous](@previous)
/*:
# Day 11: Space Police

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
On the way to Jupiter, you're pulled over by the Space Police.

"Attention, unmarked spacecraft! You are in violation of Space Law! All spacecraft must have a clearly visible registration identifier! You have 24 hours to comply or be sent to Space Jail!"

Not wanting to be sent to Space Jail, you radio back to the Elves on Earth for help. Although it takes almost three hours for their reply signal to reach you, they send instructions for how to power up the emergency hull painting robot and even provide a small Intcode program (your puzzle input) that will cause it to paint your ship appropriately.

There's just one problem: you don't have an emergency hull painting robot.
 [...]
 Build a new emergency hull painting robot and run the Intcode program on it. How many panels does it paint at least once?
 
 
: [Next](@next)
*/

import Foundation

struct Robot {
    var program: [Int: Int] = [:]
    var direction: Direction = .up
    var paintedSquares: [Square] = []
    var currentSquare: Square
    //var program: [Instruction]
    init(inputFile: String) {
        //initialize the current square
        self.currentSquare = Square(color: .black, coordinatesFromStart: (xPos: 0, yPos: 0))
        // load the program as dictionary of memory locations
        self.loadProgram(inputFile: inputFile)
    }
    mutating func moveOneSquare(){
        switch self.direction {
            case .up:
                print("\nGoing Up")
                self.currentSquare.coordinatesFromStart.yPos -= 1
                print("position \(self.currentSquare.coordinatesFromStart) \n")
            case .right:
                print("\nGoing right")
            case .left:
                print("\nGoing left")
            case .down:
                print("\nGoing down")
            }
    }
    mutating func loadProgram(inputFile: String) {
        // func getInput is in utilities file
        let input = getInput(inputFile: inputFile, extension: "txt")
        //get the input file as an array into program
        let inputProgramArray = input.components(separatedBy: ",").compactMap { Int($0) }
        let progrLength = inputProgramArray.count
        //var programBuffer = [Int](repeating: 0, count: 100000000)
        print("length : \(progrLength)")
        self.program = Dictionary(uniqueKeysWithValues: zip(0..., inputProgramArray))
    }
    mutating func runProgram() {
        print(self.program)
    }
}
struct Square {
    var color: Color = .black
    var coordinatesFromStart: (xPos: Int, yPos: Int)
    mutating func paintSquare() {
        
    }
    
}
enum Direction {
    case up, right, left, down
}
enum Color {
    case  black, white
}

var robot = Robot(inputFile: "input11")
robot.runProgram()
robot.moveOneSquare()
