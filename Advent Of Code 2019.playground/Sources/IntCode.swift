// Possible opcodes in an Intcode program.
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
// Possible modes for a parameter in an Intcode program.
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



