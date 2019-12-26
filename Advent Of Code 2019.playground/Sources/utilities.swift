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
        // ?
//        NSSetUncaughtExceptionHandler { exception in
//            print("💥 Exception thrown: \(exception)")
//        }
    }
    return input
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

/*
 Generates all possible permutations of `data` using Heap's Algorithm
 - parameters:
   - phases: The data to permute
   - output: A closure called with each permutation of the data
 */
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

