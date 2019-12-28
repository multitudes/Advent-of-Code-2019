//: [Previous](@previous)
/*:
# Day 14: Space Stoichiometry

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   

 As you approach the rings of Saturn, your ship's low fuel indicator turns on. There isn't any fuel here, but the rings have plenty of raw material. Perhaps your ship's Inter-Stellar Refinery Union brand nanofactory can turn these raw materials into fuel.

 You ask the nanofactory to produce a list of the reactions it can perform that are relevant to this process (your puzzle input). Every reaction turns some quantities of specific input chemicals into some quantity of an output chemical. Almost every chemical is produced by exactly one reaction; the only exception, ORE, is the raw material input to the entire process and is not produced by a reaction.

 You just need to know how much ORE you'll need to collect before you can produce one unit of FUEL.

 Each reaction gives specific quantities for its inputs and output; reactions cannot be partially run, so only whole integer multiples of these quantities can be used. (It's okay to have leftover chemicals when you're done, though.) For example, the reaction 1 A, 2 B, 3 C => 2 D means that exactly 2 units of chemical D can be produced by consuming exactly 1 A, 2 B and 3 C. You can run the full reaction as many times as necessary; for example, you could produce 10 D by consuming 5 A, 10 B, and 15 C.

 Suppose your nanofactory produces the following list of reactions:

 10 ORE => 10 A
 1 ORE => 1 B
 7 A, 1 B => 1 C
 7 A, 1 C => 1 D
 7 A, 1 D => 1 E
 7 A, 1 E => 1 FUEL
 The first two reactions use only ORE as inputs; they indicate that you can produce as much of chemical A as you want (in increments of 10 units, each 10 costing 10 ORE) and as much of chemical B as you want (each costing 1 ORE). To produce 1 FUEL, a total of 31 ORE is required: 1 ORE to produce 1 B, then 30 more ORE to produce the 7 + 7 + 7 + 7 = 28 A (with 2 extra A wasted) required in the reactions to convert the B into C, C into D, D into E, and finally E into FUEL. (30 A is produced because its reaction requires that it is created in increments of 10.)

 Or, suppose you have the following list of reactions:

 9 ORE => 2 A
 8 ORE => 3 B
 7 ORE => 5 C
 3 A, 4 B => 1 AB
 5 B, 7 C => 1 BC
 4 C, 1 A => 1 CA
 2 AB, 3 BC, 4 CA => 1 FUEL
 The above list of reactions requires 165 ORE to produce 1 FUEL:

 Consume 45 ORE to produce 10 A.
 Consume 64 ORE to produce 24 B.
 Consume 56 ORE to produce 40 C.
 Consume 6 A, 8 B to produce 2 AB.
 Consume 15 B, 21 C to produce 3 BC.
 Consume 16 C, 4 A to produce 4 CA.
 Consume 2 AB, 3 BC, 4 CA to produce 1 FUEL.
 Here are some larger examples:

 13312 ORE for 1 FUEL:

 157 ORE => 5 NZVS
 165 ORE => 6 DCFZ
 44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
 12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
 179 ORE => 7 PSHF
 177 ORE => 5 HKGWZ
 7 DCFZ, 7 PSHF => 2 XJWVT
 165 ORE => 2 GPVTF
 3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
 180697 ORE for 1 FUEL:

 2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
 17 NVRVD, 3 JNWZP => 8 VPVL
 53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
 22 VJHF, 37 MNCFX => 5 FWMGM
 139 ORE => 4 NVRVD
 144 ORE => 7 JNWZP
 5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
 5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
 145 ORE => 6 MNCFX
 1 NVRVD => 8 CXFTF
 1 VJHF, 6 MNCFX => 4 RFSQX
 176 ORE => 6 VJHF
 2210736 ORE for 1 FUEL:

 171 ORE => 8 CNZTR
 7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
 114 ORE => 4 BHXH
 14 VRPVC => 6 BMBT
 6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
 6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
 15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
 13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
 5 BMBT => 4 WPTQ
 189 ORE => 9 KTJDG
 1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
 12 VRPVC, 27 CNZTR => 2 XDBXC
 15 KTJDG, 12 BHXH => 5 XCVML
 3 BHXH, 2 VRPVC => 7 MZWV
 121 ORE => 7 VRPVC
 7 XCVML => 6 RJRHP
 5 BHXH, 4 VRPVC => 5 LTCX
 Given the list of reactions in your puzzle input, what is the minimum amount of ORE required to produce exactly 1 FUEL?

 Your puzzle answer was 97422.
 
 ## Part 2

 After collecting ORE for a while, you check your cargo hold: 1 trillion (1000000000000) units of ORE.

 With that much ore, given the examples above:

 - The 13312 ORE-per-FUEL example could produce 82892753 FUEL.
 - The 180697 ORE-per-FUEL example could produce 5586022 FUEL.
 - The 2210736 ORE-per-FUEL example could produce 460664 FUEL.
 
 Given 1 trillion ORE, what is the maximum amount of FUEL you can produce?
 
: [Next](@next)
*/

import Foundation

public class NanoFuelfactory {
        public var reactions: [Reaction]
        public init(input: String) {
            // reactions is an array of Reaction which are separated by newlines.
            // ex of one line : 7 A, 1 B => 1 C
            self.reactions =
                input.array(separatedBy: .newlines, using: NanoFuelfactory.parse(reaction:))
        }
    
    public class func parse(reaction: String) -> Reaction {
        // this function takes as input the string ex "7 A, 1 B => 1 C"
        // parts will be my input string divided by => or , like ["7", "A", "1", "B", "1", "C"]
        let parts = reaction.components(separatedBy: CharacterSet(charactersIn: ", =>")).filter { !$0.isEmpty }
        //print(parts)
        // the inputs of the reaction are the all my parts in the array minus the last two which is the result.
        // I organize this into an array. This will take the reaction inputs and put them into a
        // dictionary like ["A": 7, "B": 1]
        let inputs = stride(from: 0, to: parts.count-2, by: 2)
            .reduce(into: [String: Int]()) {
                $0[parts[$1+1]] = Int(parts[$1])!
        }
        //print(inputs)
        // the output is the last value of the reaction formula , in the case above it will be "C"
        let output = parts.last!
        //print(output)
        // suffix(_:)
        //Returns a subsequence, up to the given maximum length, containing the final elements of the collection.
        // my amount will be the first of the last 2 elements!
        let amount = Int(parts.suffix(2).first!)!
        // create the reaction!
        return Reaction(formula: inputs, result: output, amount: amount)
    }
    public func part1(){
        // dictionary containing quantity and name of chemical
        var generatedLeftOversDict = [String: Int]()
        var processingQueue = [String: Int]()
        // this starts with fuel and quantity
        processingQueue["FUEL"] = 1
        // I will not stop this look until processingQueue will be a dictionary with all keys = ORE so converted!
        while !processingQueue.allSatisfy { $0.key == "ORE" } {
            print("\n new loop")
            //get the first and at first only element
            let request = processingQueue.first { $0.key != "ORE" }!
            print("request \(request)")
            // first time this will be 1 with the only key Fuel
            let amountRequested = request.value
            // first time this will be - 1 !
            // generatedLeftOversDict will be empty so generatedLeftOversDict["Fuel"] will be nil defaults to zero
            let actualAmountNeeded = generatedLeftOversDict[request.key, default: 0] - amountRequested
            print("actualAmountNeeded \(actualAmountNeeded)")
            //print(request)
            //print(processingQueue)
            if actualAmountNeeded >= 0 {
                generatedLeftOversDict[request.key] = actualAmountNeeded
                processingQueue.removeValue(forKey: request.key)
            } else {
                // first pass. generatedLeftOversDict["Fuel"] will be nil, I assign zero
                generatedLeftOversDict[request.key] = 0
                // I take the first reaction producing FUEL as result
                let reaction = reactions.first { $0.result == request.key }!
                // the reaction will be formula: ["E": 1, "A": 7] result FUEL amount 1
                print("reaction : \(reaction)")
                // times will be 1/1 at first which is 1
                var times = abs(actualAmountNeeded) / reaction.amount
                if times == 0 {
                    times = 1
                }
                //- so at first time (1 * 1)% -1 = 0 .. I continue . negative modulus has no impact it is 1 % 1 = 0
                else if (times * reaction.amount) % actualAmountNeeded != 0 {
                    times += 1
                }
                
                // here it starts!  ex formula: ["E": 1, "A": 7]  2 inputs
                for input in reaction.formula {
                    print(input)
                    // will look in generatedLeftOversDict if I got a value, generatedLeftOversDict["E"] defaults to 0 if none which it is
                    // because generatedLeftOversDict starts empty and subtract 1 which is the value of input with key E * times
                    // which is 1 this makes leftover2 negative -1
                    let leftOver2 = generatedLeftOversDict[input.key, default: 0] - (input.value * times)
                    // at the beginning all generatedLeftOversDict keys needed will be 0 so the else initializes the dic
                    if leftOver2 >= 0 {
                        generatedLeftOversDict[input.key] = leftOver2
                    } else {
                        // this will assign generatedLeftOversDict["E"] = 0
                        generatedLeftOversDict[input.key] = 0
                        // this is what I need to generate = the leftover2 is -1 so I get 1 E on the processing Queue - basically at the beginning leftover 2 is the value of my input on the processing queue
                        processingQueue[input.key, default: 0] += abs(leftOver2)
                    }
                    print("generatedLeftOversDict \(generatedLeftOversDict)")
                    print("processingQueue \(processingQueue)")
                }
                
                // first pass in generatedLeftOversDict[Fuel] will be 0 and I add (-1) the value of leftover (times is 1)
                generatedLeftOversDict[request.key, default: 0] += actualAmountNeeded + (reaction.amount * times)
                // generatedLeftOversDict[Fuel] is now 0
                if generatedLeftOversDict[request.key, default: 0] < 0 {
                    // first pass processingQueue[Fuel] will be updated / stays here the same => 1
                    processingQueue[request.key, default: 0] = abs(actualAmountNeeded) - (reaction.amount * times)
                    // first pass here stays the same => 0
                    generatedLeftOversDict[request.key] = 0
                } else {
                    //reaction.amount * times is 1 * 1 = 1 so I substract 1 and I got the request removed!
                    // the first request was Fuel with amount 1. removed from processingqueue and replaced
                    // with the formula elements 7A and 1E without any generatedLeftOversDict leftovers
                    processingQueue[request.key, default: 0] -= (reaction.amount * times)
                    if processingQueue[request.key, default: 0] <= 0 {
                        processingQueue.removeValue(forKey: request.key)
                    }
                }
            }
            print("generatedLeftOversDictAfter \(generatedLeftOversDict)")
            print("processingQueueAfter \(processingQueue)")
                            do {
                                sleep(3)
                            }
        } // the while loop continues . my processing q will have still no ore at first
        
        generatedLeftOversDict = generatedLeftOversDict.filter { $0.value != 0 }
    }
}

public struct Reaction: CustomStringConvertible {
    public var formula: [String: Int]
    public var result: String
    public var amount: Int
    public var description: String{
        let text = "formula: \(formula) result \(result) amount \(amount)"
        return text
    }
}
var input = getInput(inputFile: "input14a", extension: "txt")
let chemicalReaction = NanoFuelfactory(input: input)
chemicalReaction.part1()

//print(chemicalReaction.reactions)


//public func load(from input: [String]) -> [String: Reaction] {
//    return input.map { line -> Reaction in
//        let parts = line.components(separatedBy: " => ")
//        let input = parts[0].components(separatedBy: ", ").map { $0.components(separatedBy: " ")}
//        let output = parts[1].components(separatedBy: " ")
//        return Reaction(formula: input, result: result, amount: )
//    }
//    .reduce(into: [:]) { result, next in result[next.result] = next }
//}
