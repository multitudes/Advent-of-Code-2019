
public class IntCodeComputer {
    public var index = 0
    public var relativeBase = 0
    public var outputs = [Int]()
    public var program: [Int:Int]
    
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
//                print("\nadd!")
//                print("parameters: \(instruction.parameters)")
                program[instruction.parameters[2]] = instruction.parameters[0] + instruction.parameters[1]
//                print("value: \(instruction.parameters[0]) + \(instruction.parameters[1]) = \(instruction.parameters[0] + instruction.parameters[1]) written to \(instruction.parameters[2])")
//                print("is this right ? \(program[instruction.parameters[2]]!)\n")
                index += 4
            case .multiply:
//                print("multiply ")
//                print( instruction.parameters)
                program[instruction.parameters[2]] = instruction.parameters[0] * instruction.parameters[1]
//                print("value: \(instruction.parameters[0]) * \(instruction.parameters[1]) = \(instruction.parameters[0] * instruction.parameters[1]) written to \(instruction.parameters[2])")
//                print("is this right ? \(program[instruction.parameters[2]]!)\n")
                index += 4
            case .input:
                print("\n TEST Input: 2 ")
                // readLine does not work in Playgrounds 😅 I will hardcode it
                program[instruction.parameters[0]] = 2
                index += 2
            case .output:
                print("output got: \(instruction.parameters[0])")
                index += 2
                outputs.append(instruction.parameters[0])
//                print("continue with \(program[index]!)\n")
            case .jumpIfTrue:
                //Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
//                print("jumpIfTrue")
//                print( instruction.parameters)
                //print("range: \(program[index...index+2])")
                if instruction.parameters[0] != 0 {
                    index = instruction.parameters[1]
//                    print("jump to index \(index)\n")
                    } else {
                    index += 3
//                    print("continue with \(program[index]!)\n")
                }
                
            case .jumpIfFalse:
                //Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
//                print("jumpIfFalse")
//                print( instruction.parameters)
                //print("range: \(program[index...index+2])")
                if instruction.parameters[0] == 0 {
                    index = instruction.parameters[1]
//                    print("jump to \(program[index]!)\n")
                    continue
                    } else {
                    index += 3
//                    print("continue with \(program[index]!)\n")
                }
                
            case .lessThan:
                //Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
//                print("lessThan")
//                print( instruction.parameters)
                if instruction.parameters[0] < instruction.parameters[1] {
                    program[instruction.parameters[2]] = 1 } else {
                    program[instruction.parameters[2]] = 0
                }
//                print("value: if \(instruction.parameters[0]) < \(instruction.parameters[1]) then 1 written to \(instruction.parameters[2])")
//                print("is this right ? \(program[instruction.parameters[2]]!)\n")
                index += 4
            
            case  .equals:
//                print("equals")
//                print( instruction.parameters)
                if instruction.parameters[0] == instruction.parameters[1] {
                    program[instruction.parameters[2]] = 1 } else {
                    program[instruction.parameters[2]] = 0
                }
//                print("value: if \(instruction.parameters[0]) = \(instruction.parameters[1]) then 1 written to \(instruction.parameters[2])")
//                print("is this right ? \(program[instruction.parameters[2]]!)\n")
                index += 4
            case .relativeBaseOffset:
//                print("relativeBaseOffset")
//                print( instruction.parameters)
                relativeBase += instruction.parameters[0]
//                print("relativeBase is now  = \(relativeBase)\n")
                index += 2
            case .halt:
                print("stop")
            }
        }
        print("stop\n ---------------------------------------------- \n -------------------------------------------------- \n")
        print("Outputs \(outputs)")
        return outputs
    }

}

