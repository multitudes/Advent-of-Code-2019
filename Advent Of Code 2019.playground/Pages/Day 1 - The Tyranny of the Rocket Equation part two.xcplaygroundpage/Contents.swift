//: [Previous](@previous)
/*:
# Day 1: The Tyranny of the Rocket Equation
###            --- Part Two ---

[See it on github](https://github.com/multitudes/Advent-of-Code-2019)
 
During the second Go / No Go poll, the Elf in charge of the Rocket Equation Double-Checker stops the launch sequence. Apparently, you forgot to include additional fuel for the fuel you just added.

Fuel itself requires fuel just like a module - take its mass, divide by three, round down, and subtract 2. However, that fuel also requires fuel, and that fuel requires fuel, and so on. Any mass that would require negative fuel should instead be treated as if it requires zero fuel; the remaining mass, if any, is instead handled by wishing really hard, which has no mass and is outside the scope of this calculation.

So, for each module mass, calculate its fuel and add it to the total. Then, treat the fuel amount you just calculated as the input mass and repeat the process, continuing until a fuel requirement is zero or negative. For example:

A module of mass 14 requires 2 fuel. This fuel requires no further fuel (2 divided by 3 and rounded down is 0, which would call for a negative fuel), so the total fuel required is still just 2.
At first, a module of mass 1969 requires 654 fuel. Then, this fuel requires 216 more fuel (654 / 3 - 2). 216 then requires 70 more fuel, which requires 21 fuel, which requires 5 fuel, which requires no further fuel. So, the total fuel required for a module of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966.
The fuel required by a module of mass 100756 and its fuel is: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346.
What is the sum of the fuel requirements for all of the modules on your spacecraft when also taking into account the mass of the added fuel? (Calculate the fuel requirements for each module separately, then add them all up at the end.)
&nbsp;

[Next >](@next)
*/
import Foundation

// declaring the var containing the input
var input = ""

// this will look in my resources folder for the input.txt file which is still the same
do {
    guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else { fatalError() }
    input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
} catch {
    print(error)
}

//get the input file as an array into moduleMass
var moduleMasses = input.components(separatedBy: "\n")

// recursive function to get the total fuel
func calculateFuel(fuel: Int) -> Int {
    if fuel <= 0 { return 0 }
    return fuel + calculateFuel(fuel: fuel / 3 - 2)
}

//a little bit of functional programming. the filter() method creates a new array from an existing one, selecting from it only items that match a function you provide
moduleMasses = moduleMasses.filter { $0 != "" }

// and compactMap transform the elements of an array just like map() does, except once the transformation completes an extra step happens: all optionals get unwrapped, and any nil values get discarded.
var fuel = moduleMasses.compactMap { Int($0) }.map {  (fuel: Int) -> Int in
                                                    let fuelmass = fuel / 3 - 2
                                                    return  calculateFuel(fuel: fuelmass)}

//Reduce allows us to extract one single value from a sequence, by performing a series of operations in the sequence’s elements.
let totalFuel = fuel.reduce(0, +)

print("The answer is : \(totalFuel)")

// The answer is : 4728317

//: [Next](@next)
