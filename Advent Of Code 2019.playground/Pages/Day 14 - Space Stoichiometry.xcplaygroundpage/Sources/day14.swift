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
        var leftOversDict = [String: Int]()
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
            // leftOversDict will be empty so leftOversDict["Fuel"] will be nil defaults to zero
            let actualAmountNeeded = amountRequested - leftOversDict[request.key, default: 0]
            print("actualAmountNeeded \(actualAmountNeeded)")
            //print(request)
            //print(processingQueue)
            if actualAmountNeeded <= 0 {
                leftOversDict[request.key] = abs(actualAmountNeeded)
                processingQueue.removeValue(forKey: request.key)
            } else {
                // first pass. leftOversDict["Fuel"] will be nil, I assign zero
                leftOversDict[request.key] = 0
                // I take the first reaction producing FUEL as result
                let reaction = reactions.first { $0.result == request.key }!
                // the reaction will be formula: ["E": 1, "A": 7] result FUEL amount 1
                print("reaction : \(reaction)")
                // multiplier will be 1/1 at first which is 1
                var multiplier = actualAmountNeeded / reaction.amount
                if multiplier == 0 {
                    multiplier = 1
                }
                //- so at first time (1 * 1)% -1 = 0 .. I continue . negative modulus has no impact it is 1 % 1 = 0
                else if (multiplier * reaction.amount) % actualAmountNeeded != 0 {
                    multiplier += 1
                }
                
                // here it starts!  ex formula: ["E": 1, "A": 7]  2 inputs
                for input in reaction.formula {
                    print(input)
                    // will look in leftOversDict if I got a value, leftOversDict["E"] defaults to 0 if none which it is
                    // because leftOversDict starts empty and subtract 1 which is the value of input with key E * multiplier
                    // which is 1 this makes updatedValue negative -1
                    let updatedValue = (input.value * multiplier) - leftOversDict[input.key, default: 0]
                    // at the beginning all leftOversDict keys needed will be 0 so the else initializes the dic
                    if updatedValue <= 0 {
                        leftOversDict[input.key] = abs(updatedValue)
                    } else {
                        // this will assign leftOversDict["E"] = 0
                        leftOversDict[input.key] = 0
                        // this is what I need to generate = the updatedValue is -1 so I get 1 E on the processing Queue - basically at the beginning leftover 2 is the value of my input on the processing queue
                        processingQueue[input.key, default: 0] += updatedValue
                    }
                    print("leftOversDict \(leftOversDict)")
                    print("processingQueue \(processingQueue)")
                }
                
                // first pass in leftOversDict[Fuel] will be 0 and I add (-1) the value of leftover (multiplier is 1)
                leftOversDict[request.key, default: 0] +=  (reaction.amount * multiplier) - actualAmountNeeded
                // leftOversDict[Fuel] is now 0
                if leftOversDict[request.key, default: 0] < 0 {
                    // first pass processingQueue[Fuel] will be updated / stays here the same => 1
                    processingQueue[request.key, default: 0] = abs(actualAmountNeeded) - (reaction.amount * multiplier)
                    // first pass here stays the same => 0
                    leftOversDict[request.key] = 0
                } else {
                    //reaction.amount * multiplier is 1 * 1 = 1 so I substract 1 and I got the request removed!
                    // the first request was Fuel with amount 1. removed from processingqueue and replaced
                    // with the formula elements 7A and 1E without any leftOversDict leftovers
                    processingQueue[request.key, default: 0] -= (reaction.amount * multiplier)
                    if processingQueue[request.key, default: 0] <= 0 {
                        processingQueue.removeValue(forKey: request.key)
                    }
                }
            }
            print("leftOversDictAfter \(leftOversDict)")
            print("processingQueueAfter \(processingQueue)")
            // for debug                            do {  sleep(3) }
        } // the while loop continues . my processing q will have still no ore at first
        
        leftOversDict = leftOversDict.filter { $0.value != 0 }
        print("leftOversDict : \(leftOversDict)")
        print("\n\nSolution part one Ore needed is : \(processingQueue["ORE"] ?? 0)\n")
    }
    public func part2() {
        
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
