public extension StringProtocol  {
    var digits: [Int] { compactMap{ $0.wholeNumberValue } }
}
public extension LosslessStringConvertible {
    var string: String { .init(self) }
}
public extension Numeric where Self: LosslessStringConvertible {
    var digits: [Int] { string.digits }
}
import Foundation
//this will look in my resources folder for the input.txt file
public func getInput(inputFile: String, extension: String) -> String {
    var input = ""
    do {
        guard let fileUrl = Bundle.main.url(forResource: inputFile, withExtension: "txt") else { fatalError() }
        input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
    } catch {
        print(error)
    }
    return input
}

public func createInstruction(program: [Int], index: Int) -> Instruction {
    let opcode: Opcode = Opcode(rawValue: program[index] % 100)!
    let modes = [ Mode(rawValue: program[index] % 1000 / 100)!, Mode(rawValue: program[index] / 1000)! ]
    let firstParam: Int; let secondParam: Int; var parameters: [Int] = []
    switch opcode {
    case .add, .multiply, .equals, .lessThan, .jumpIfTrue, .jumpIfFalse:
            if modes[0] == .position {
                           firstParam = program[program[index + 1]]
                        } else {
                             firstParam = program[index + 1]
                        }
            if modes[1] == .position {
                         secondParam = program[program[index + 2]]
                        } else {
                         secondParam = program[index + 2]
                       }
            parameters = [firstParam, secondParam]
        case .input:
            if modes[0] == .position {
                           firstParam = program[program[index + 1]]
                        } else {
                             firstParam = program[index + 1]
                        }
            parameters = [firstParam]
        case .output:
            if modes[0] == .position {
                           firstParam = program[program[index + 1]]
                        } else {
                             firstParam = program[index + 1]
                        }
            parameters = [firstParam]
    case .halt:
        print("stop")
        }
    return Instruction(opcode: opcode, parameters: parameters, modes: modes)
}

public func phasePermutation<T>(phases: inout Array<T>, output: (Array<T>) -> Void) {
    generate(n: phases.count, phases: &phases, output: output)
}

public func generate<T>(n: Int, phases: inout Array<T>, output: (Array<T>) -> Void) {
    if n == 1 {
        output(phases)
    } else {
        for i in 0 ..< n {
            generate(n: n - 1, phases: &phases, output: output)
            if n % 2 == 0 {
                phases.swapAt(i, n - 1)
            } else {
                phases.swapAt(0, n - 1)
            }
        }
    }
}
