//: [Previous](@previous)


//: [Next](@next)

import Foundation


var myString = "\(-10)"
if let myNumber = NumberFormatter().number(from: myString) {
    let myInt = myNumber.intValue
       // do what you need to do with myInt
    print(myInt)
  } else {
       // what ever error code you need to write
  }

let myNumberint: Int? = NumberFormatter().number(from: myString)?.intValue

