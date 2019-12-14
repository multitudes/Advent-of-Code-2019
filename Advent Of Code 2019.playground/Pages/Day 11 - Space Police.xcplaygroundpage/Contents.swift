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
    var paintedSquares = Set<Square>()
    var currentSquare: Square
    //var program: [Instruction]
    init(inputFile: String) {
        //initialize the current square--- for part two it will start white!
        self.currentSquare = Square(color: .white, coordinatesFromStart: (xPos: 0, yPos: 0))
        // load the program as dictionary of memory locations
        self.loadProgram(inputFile: inputFile)
    }
    mutating func paintSquare(color: Color){
        self.currentSquare.color = color
        //Return Value is (true, newMember) if newMember was not contained in the set. If an element equal to newMember was already contained in the set, the method returns (false, oldMember), where oldMember is the element that was equal to newMember.
        if self.paintedSquares.insert(currentSquare).0 == false {
            print("you have been here before")
            self.paintedSquares.update(with: currentSquare)
            print("updated with \(currentSquare.color)\n")
        }
        print("color is now \(self.currentSquare.color)")
    }
    func returnColorAtCurrentSquare() -> Color {
        return self.currentSquare.color
    }
    mutating func moveOneSquare(){
        switch self.direction {
            case .up:
                print("\nGoing Up")
                self.currentSquare.coordinatesFromStart.yPos -= 1
                print("position \(self.currentSquare.coordinatesFromStart)")
            case .right:
                print("\nGoing right")
                self.currentSquare.coordinatesFromStart.xPos += 1
                print("position \(self.currentSquare.coordinatesFromStart)")
            case .left:
                print("\nGoing left")
                self.currentSquare.coordinatesFromStart.xPos -= 1
                print("position \(self.currentSquare.coordinatesFromStart)")
            case .down:
                print("\nGoing down")
                self.currentSquare.coordinatesFromStart.yPos += 1
                print("position \(self.currentSquare.coordinatesFromStart)")
            }
        // need to update currentSquare after moving. if i already visited that square then the color could be white or black. else is black by defaault
        if let alreadyVisited = self.paintedSquares.first(where: { $0.coordinatesFromStart == self.currentSquare.coordinatesFromStart }) {
            self.currentSquare.color = alreadyVisited.color
        } else {
            self.currentSquare.color = .black
        }
        print("currentSquare color \(self.currentSquare.color)")
        print("number of square visited = \(self.paintedSquares.count) \n\n")

    }
    mutating func changeDirection(to: Direction) {
        switch to {
            case .left:
                self.direction = Direction(rawValue: ((self.direction.rawValue + 4 - 1) % 4) )!
                
            case .right:
                self.direction = Direction(rawValue: ((self.direction.rawValue + 4 + 1) % 4) )!
            default: print("\nOnly left or right changes allowed! \n")
        }
        self.direction
    }
    mutating func loadProgram(inputFile: String) {
        // func getInput is in utilities file
        let input = getInput(inputFile: inputFile, extension: "txt")
        //get the input file as an array into program
        let inputProgramArray = input.components(separatedBy: ",").compactMap { Int($0) }
        let progrLength = inputProgramArray.count
        //var programBuffer = [Int](repeating: 0, count: 100000000)
        print("last two : \(inputProgramArray[progrLength-2]) == \(inputProgramArray[progrLength-1])")
        self.program = Dictionary(uniqueKeysWithValues: zip(0..., inputProgramArray))
    }
    mutating func runProgram() {
        print(self.program)
        var index = 0; var relativeBase = 0; var outputs = [Int]();  var input: Int = 0
        print(index)
        print(outputs)
        // the index will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
        //while outputs.count != 1 {
        while program[index] != 99 {
            //print("Prog: \(program)")
            // just in case initialize some memory here
            for i in 0..<4 {
                if index <= 0 { index = 0 }
                if program[index + i] == nil { program[index + i] == 0 }
                if program[index]! / 10000 > 3 { print("\n error opcode =================\n "); break }
            }
            print("instr range: \(program[index] ?? 0) - \(program[index+1] ?? 0) - \(program[index+2] ?? 0) - \(program[index+3] ?? 0)")
            print("index: \(index)")
            print("relativeBase: \(relativeBase)")
                        
            // func createInstruction is in utilities file and returns an instance of the Instruction struct
            let instruction = createInstruction(program: program , index: index, relativeBase: relativeBase)
            switch instruction.opcode {
                case .add:
                    print("\nadd! got it")
                    print("parameters: \(instruction.parameters)")
                    program[instruction.parameters[2]] = instruction.parameters[0] + instruction.parameters[1]
                    print("value: \(instruction.parameters[0]) + \(instruction.parameters[1]) = \(instruction.parameters[0] + instruction.parameters[1]) written to \(instruction.parameters[2])")
                    print("is this right ? \(program[instruction.parameters[2]]!)\n")
                    index += 4
                case .multiply:
                    print("multiply ")
                    print( instruction.parameters)
                    program[instruction.parameters[2]] = instruction.parameters[0] * instruction.parameters[1]
                    print("value: \(instruction.parameters[0]) * \(instruction.parameters[1]) = \(instruction.parameters[0] * instruction.parameters[1]) written to \(instruction.parameters[2])")
                    print("is this right ? \(program[instruction.parameters[2]]!)\n")
                    index += 4
                case .input:
                    input = self.returnColorAtCurrentSquare().rawValue
                    print("\n TEST Input is current color of square: \(Color(rawValue: input)!) ")
                    var firstParam = 0
                    if instruction.modes[0] == .position {
                            if let a = program[index + 1] {
                                firstParam = a }}
                    else if instruction.modes[0] == .relative {
                            if let a = program[index + 1] {
                                firstParam = a + relativeBase }}
                        else {
                            print("\n\nerror write cannot have immediate mode 1 \n\n")
                    }
                    program[firstParam] = input
                    print("value: \(input)  written to \(firstParam)")
                    print("is this right ? \(program[firstParam]!)\n")
                    index += 2
                case .output:
                    print("output got: \(instruction.parameters[0])")
                    outputs.append(instruction.parameters[0])
                    if outputs.count == 2 {
                        print("outputs are \(outputs)")
                        print("painting \(Color(rawValue: outputs[0]) ?? .black) and moving one square")
                        self.paintSquare(color: Color(rawValue: outputs[0]) ?? .black)
                        if outputs[1] == 1 { outputs[1] += 1 }// to get turn right}
                            self.changeDirection(to: Direction(rawValue: outputs[1]) ?? .up)
                        self.moveOneSquare()
                        outputs = []
                    }
                    index += 2
                    
                    print("continue with \(program[index]!)\n")
                case .jumpIfTrue:
                    //Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
                    print("jumpIfTrue")
                    print( instruction.parameters)
                    //print("range: \(program[index...index+2])")
                    if instruction.parameters[0] != 0 {
                        index = instruction.parameters[1]
                        print("jump to index \(index)\n")
                        continue
                        } else {
                        index += 3
                        print("continue with \(program[index]!)\n")
                    }
                    
                case .jumpIfFalse:
                    //Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
                    print("jumpIfFalse")
                    print( instruction.parameters)
                    //print("range: \(program[index...index+2])")
                    if instruction.parameters[0] == 0 {
                        index = instruction.parameters[1]
                        print("jump to \(program[index]!)\n")
                        continue
                        } else {
                        index += 3
                        print("continue with \(program[index]!)\n")
                    }
                    
                case .lessThan:
                    //Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
                    print("lessThan")
                    print( instruction.parameters)
                    if instruction.parameters[0] < instruction.parameters[1] {
                        program[instruction.parameters[2]] = 1 } else {
                        program[instruction.parameters[2]] = 0
                    }
                    print("value: if \(instruction.parameters[0]) < \(instruction.parameters[1]) then 1 written to \(instruction.parameters[2])")
                    print("is this right ? \(program[instruction.parameters[2]]!)\n")
                    index += 4
                
                case  .equals:
                    print("equals")
                    print( instruction.parameters)
                    if instruction.parameters[0] == instruction.parameters[1] {
                        program[instruction.parameters[2]] = 1 } else {
                        program[instruction.parameters[2]] = 0
                    }
                    print("value: if \(instruction.parameters[0]) = \(instruction.parameters[1]) then 1 written to \(instruction.parameters[2])")
                    print("is this right ? \(program[instruction.parameters[2]]!)\n")
                    index += 4
                case .relativeBaseOffset:
                    print("relativeBaseOffset")
                    print( instruction.parameters)
                    relativeBase += instruction.parameters[0]
                    print("relativeBase is now  = \(relativeBase)\n")
                    index += 2
                case .halt:
                    print("stop")
                
           }
        }
        print("stop\n ---------------------------------------------- \n -------------------------------------------------- \n")
            //print(program)
        print("Outputs \(outputs)")
        
    }
}
struct Square: Hashable {
    // this is tricking swift to make sets of spaceobjects. The class needs to conform to hashable and equatable.
    static func == (lhs: Square, rhs: Square) -> Bool {
        return lhs.coordinatesFromStart == rhs.coordinatesFromStart
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(coordinatesFromStart.xPos)
        hasher.combine(coordinatesFromStart.yPos)
        }
    var color: Color = .black
    var coordinatesFromStart: (xPos: Int, yPos: Int)
    mutating func paintSquare() {
        
    }
    
}
enum Direction: Int {
    case left, up, right, down
}
enum Color: Int {
    case  black, white
}

var robot = Robot(inputFile: "input11")
robot.runProgram()
robot.moveOneSquare()
robot.paintSquare(color: .white)
robot.changeDirection(to: .left)
robot.moveOneSquare()
robot.paintSquare(color: .white)
robot.changeDirection(to: .left)
robot.moveOneSquare()
robot.paintSquare(color: .white)
robot.changeDirection(to: .left)
robot.moveOneSquare()
robot.paintSquare(color: .white)
robot.changeDirection(to: .left)
robot.moveOneSquare()
robot.paintSquare(color: .white)

print(robot.paintedSquares.count)
robot.changeDirection(to: .left)
robot.moveOneSquare()
robot.changeDirection(to: .up)
robot.moveOneSquare()
robot.changeDirection(to: .right)
robot.moveOneSquare()
robot.changeDirection(to: .down)
robot.moveOneSquare()
