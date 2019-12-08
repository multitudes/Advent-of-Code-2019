// Possible opcodes in an Intcode program.
public enum Opcode: Int {
    case add = 1,
        multiply = 2,
        input = 3,
        output = 4,
        halt = 99
}
// Possible modes for a parameter in an Intcode program.
enum Mode: Int {
    case position = 0,
        immediate = 1

}
// the instruction will be ABCDE the last two digit the opcodes and the rest parameters
struct Instruction {
    let opcode: Opcode
    let parameters: [Int]
    // +1 for the opcode
    var length: Int { return parameters.count + 1 }
}

public func writeInput(input: Int, to: Int) {
    
}
