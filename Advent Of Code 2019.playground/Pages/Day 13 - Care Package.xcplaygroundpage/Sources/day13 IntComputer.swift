public class IntCodeComputer {
    public var index = 0
    public var relativeBase = 0
    public var outputs = [Int]()
    public var program: [Int:Int]
    // these are for part 2 day 13
    public var ballPosition = Coordinate.zero
    public var paddlePosition = Coordinate.zero
    public var score = 0
    public var output: [Int] = []
    
    public init(program: [Int:Int]) {
        self.index = 0
        self.outputs = []
        self.program = program
    }

    public func run() -> [Int] {
    // the index will move at various intervals. I check everytime for the opcode 99 then I continue on the loop
    //while outputs.count != 1 {
    
        while program[index] != 99 {

        if index <= 0 { index = 0 }
        
//        print("instr range: \(program[index] ?? 0) - \(program[index+1] ?? 0) - \(program[index+2] ?? 0) - \(program[index+3] ?? 0)")
//        print("index: \(index)")
//        print("relativeBase: \(relativeBase)")
        //print("Prog: \(program)")
        
        if program[index]! / 10000 > 3 {
            print("\n error opcode =================\n ")
            break
        }
        // func createInstruction is in utilities file and returns an instance of the Instruction struct
        let instruction = createInstruction(program: program , index: index, relativeBase: relativeBase)
        switch instruction.opcode {
            case .add:
                program[instruction.parameters[2]] = instruction.parameters[0] + instruction.parameters[1]
                index += 4
            case .multiply:
                program[instruction.parameters[2]] = instruction.parameters[0] * instruction.parameters[1]
                index += 4
            case .input:
                //print("\n TEST Input: 2 ")
                // readLine does not work in Playgrounds 😅 I will hardcode it
                if ballPosition.x < paddlePosition.x {
                    program[instruction.parameters[0]] = -1
                } else if ballPosition.x > paddlePosition.x {
                    program[instruction.parameters[0]] = 1
                } else {
                    program[instruction.parameters[0]] = 0
                }
                index += 2
            case .output:
                 index += 2
                outputs.append(instruction.parameters[0])
                output.append(instruction.parameters[0])
                if output.count == 3 {
                    if (output[0] == -1) && output[1] == 0 {
                        score = output[2]
                    } else {
                        let coord = Coordinate(x: output[0], y: output[1])
                        let tile = TileType(rawValue: output[2])!
                        //screen[coord] = tile
                        if tile == .ball {
                            ballPosition = coord
                        } else if tile == .paddle {
                            paddlePosition = coord
                        }
                    }
                    output = []
                    //draw(screen, score: score)
                }
            
            case .jumpIfTrue:
                if instruction.parameters[0] != 0 {
                    index = instruction.parameters[1]

                    } else {
                    index += 3
               }
                
            case .jumpIfFalse:

                if instruction.parameters[0] == 0 {
                    index = instruction.parameters[1]

                    continue
                    } else {
                    index += 3

                }
                
            case .lessThan:
                if instruction.parameters[0] < instruction.parameters[1] {
                    program[instruction.parameters[2]] = 1 } else {
                    program[instruction.parameters[2]] = 0
                }
                index += 4
            case  .equals:
                if instruction.parameters[0] == instruction.parameters[1] {
                    program[instruction.parameters[2]] = 1 } else {
                    program[instruction.parameters[2]] = 0
                }
                index += 4
            case .relativeBaseOffset:
                relativeBase += instruction.parameters[0]
                index += 2
            case .halt:
                print("stop")
            }
        }
        if program[0] == 2 {
            print("Solution part 2 is score: \(score)")
        }
        return outputs
    }
    
    public func createInstruction(program: [Int: Int], index: Int, relativeBase: Int) -> Instruction {
        
        let opcode: Opcode = Opcode(rawValue: program[index]! % 100)!
        let modes = [ Mode(rawValue: program[index]! % 1000 / 100)!, Mode(rawValue: program[index]! % 10000 / 1000)! , Mode(rawValue: program[index]! / 10000)!]
        var firstParam: Int = 0; var secondParam: Int = 0; var thirdParam: Int = 0; var parameters: [Int] = []
        
        switch opcode {
        case .add, .multiply, .equals, .lessThan:
                if modes[0] == .position {
                    if let a = program[index + 1] {
                        if let b = program[a] { firstParam = b } else { firstParam = 0 }}}
                else if modes[0] == .relative {
                    if let a = program[index + 1] {
                        if let b = program[a + relativeBase] { firstParam = b } else { firstParam = 0 }}}
                else {
                    firstParam = program[index + 1] ?? 0
                    }
                if modes[1] == .position {
                    if let a = program[index + 2] {
                        if let b = program[a] { secondParam = b } else { secondParam = 0 }}}
                else if modes[1] == .relative {
                    if let a = program[index + 2] {
                        if let b = program[a + relativeBase] { secondParam = b } else { secondParam = 0 }}}
                else {
                    secondParam = program[index + 2] ?? 0
                }
                if modes[2] == .position {
                    if let a = program[index + 3] {
                        thirdParam = a }}
                else if modes[2] == .relative {
                    if let a = program[index + 3] {
                            thirdParam = a + relativeBase }}
                else {
                    print("\n\nerror write cannot have immediate mode 1 \n\n")
                }
                parameters = [firstParam, secondParam, thirdParam]
            
            case .input:
                if modes[0] == .position {
                        if let a = program[index + 1] {
                            firstParam = a }}
                else if modes[0] == .relative {
                        if let a = program[index + 1] {
                            firstParam = a + relativeBase }}
                    else {
                        print("\n\nerror write cannot have immediate mode 1 \n\n")
                }
                parameters = [firstParam]
            case .output:
                if modes[0] == .position {
                        if let a = program[index + 1] {
                            if let b = program[a] { firstParam = b }  else { firstParam = 0 }}}
                else if modes[0] == .relative {
                        if let a = program[index + 1] {
                            if let b = program[a + relativeBase] {
                                firstParam = b }
                            else { firstParam =  0 }}}
                    else {
                        firstParam = program[index + 1] ?? 0
                }
                parameters = [firstParam]
            
            case .jumpIfTrue, .jumpIfFalse:
                if modes[0] == .position {
                    if let a = program[index + 1] {
                        if let b = program[a] { firstParam = b } else { firstParam = 0 }}}
                else if modes[0] == .relative {
                    if let a = program[index + 1] {
                        if let b = program[a + relativeBase] { firstParam = b } else { firstParam = 0 }}}
                else {
                    firstParam = program[index + 1] ?? 0
                    }
                if modes[1] == .position {
                    if let a = program[index + 2] {
                        if let b = program[a] { secondParam = b } else { secondParam = 0 }}}
                else if modes[1] == .relative {
                    if let a = program[index + 2] {
                        if let b = program[a + relativeBase] { secondParam = b } else { secondParam = 0 }}}
                else {
                    secondParam = program[index + 2] ?? 0
                }
                parameters = [firstParam, secondParam]

            
            case .relativeBaseOffset:
                if modes[0] == .position {
                        if let a = program[index + 1] {
                            if let b = program[a] { firstParam = b } else { firstParam = 0 }}}
                else if modes[0] == .relative {
                        if let a = program[index + 1] {
                            if let b = program[a + relativeBase] { firstParam = b } else { firstParam = 0 }}}
                    else {
                        firstParam = program[index + 1] ?? 0
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
    // +1 for the opcode
    var length: Int { return parameters.count + 1 }
}

    
