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
        halt = 99
}
// Possible modes for a parameter
public enum Mode: Int {
    case position = 0,
        immediate = 1

}
// the instruction will be ABCDE the last two digit the opcodes and the rest parameters
public struct Instruction {
    public let opcode: Opcode
    public var parameters: [Int]
    var modes: [Mode]
    // +1 for the opcode
    var length: Int { return parameters.count + 1 }
}


// My computer. // got some inspiration from Kaitlin Mahar for this. I still have lots to learn!!
public struct Computer {
    public var program: [Int]
    public var inputs: [Int]
    public var outputs: [Int] = []
    public var iP: Int = 0
    public var isHalted = false
    
    // Initializes a new Computer
    public init(program: [Int], inputs: [Int] = []) {
        self.program = program
        self.inputs = inputs
    }

    // Takes an output of the program (FIFO).
    public mutating func getOutput() -> Int {
        return self.outputs.removeFirst()
    }

    // Reads parameters for an instruction
    public func readParams(count: Int) -> [Int] {
        // remove the opcode
        var modeData = self.program[iP] / 100
        var modes = [Mode]()
        for _ in 0..<count {
            let lastDigit = modeData % 10
            let mode = Mode(rawValue: lastDigit)!
            modes.append(mode)
            modeData /= 10
        }

        return (0..<count).map { i in
            let idx = self.iP + 1 + i
            switch modes[i] {
            case .position:
                return self.program[program[idx]]
            case .immediate:
                return self.program[idx]
            }
        }
    }

    // Reads the next instruction
    public func readNextInstruction() -> Instruction {
        let first = self.program[iP]
        //  opcode. % 100 to get last two digits.
        let opcode = Opcode(rawValue: first % 100)!

        switch opcode {
        case .add, .multiply, .equals, .lessThan:
            let params = self.readParams(count: 2)
            return Instruction(opcode: opcode, parameters: params + [self.program[self.iP + 3]], modes: [])
        case .jumpIfTrue, .jumpIfFalse:
            let params = self.readParams(count: 2)
            return Instruction(opcode: opcode, parameters: params, modes: [])
        case .input:
            return Instruction(opcode: opcode, parameters: [self.program[self.iP + 1]], modes: [])
        case .output:
            let params = self.readParams(count: 1)
            return Instruction(opcode: opcode, parameters: params, modes: [])
        case .halt:
            return Instruction(opcode: opcode, parameters: [], modes: [])
        }
    }

    // Executes the next instruction in the program. Has no effect if the program has already halted or if the
    // instruction pointer reaches the end of the program.
    public mutating func step() {
        guard !self.isHalted && self.iP < program.count else {
            return
        }
        let instruction = self.readNextInstruction()
        let params = instruction.parameters
        switch instruction.opcode {
        case .add:
            self.program[params[2]] = params[0] + params[1]
        case .multiply:
            self.program[params[2]] = params[0] * params[1]
        case .equals:
            self.program[params[2]] = params[0] == params[1] ? 1 : 0
        case .lessThan:
            self.program[params[2]] = params[0] < params[1] ? 1 : 0
        case .input:
            self.program[params[0]] = self.inputs.removeFirst()
        case .output:
            self.outputs.append(params[0])
        case .jumpIfTrue:
            if params[0] != 0 {
                self.iP = params[1]
                return // return to avoid incrementing iP below
            }
        case .jumpIfFalse:
            if params[0] == 0 {
                self.iP = params[1]
                return // return to avoid incrementing iP below
            }
        case .halt:
            self.isHalted = true
            return
        }
        self.iP += instruction.length
    }

    // Runs the program until it next produces output or until the program halts. If an output is produced, returns
    // the output. If the program halts, returns nil.
    public mutating func runProgram() -> Int? {
        while self.iP < self.program.count && !self.isHalted && self.outputs.count == 0 {
            self.step()
        }
        return self.outputs.count > 0 ? self.getOutput() : nil
    }

    // Runs the program until it halts.
    public mutating func runProgramUntilEnd() {
        // iterate
        while self.iP < self.program.count && !self.isHalted {
            self.step()
        }
    }
}
