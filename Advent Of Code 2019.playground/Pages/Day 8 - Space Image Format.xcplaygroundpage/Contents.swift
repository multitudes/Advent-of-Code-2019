//: [Previous](@previous)
/*:
# Day 8: Space Image Format

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
The Elves' spirits are lifted when they realize you have an opportunity to reboot one of their Mars rovers, and so they are curious if you would spend a brief sojourn on Mars. You land your ship near the rover.

When you reach the rover, you discover that it's already in the process of rebooting! It's just waiting for someone to enter a BIOS password. The Elf responsible for the rover takes a picture of the password (your puzzle input) and sends it to you via the Digital Sending Network.

Unfortunately, images sent via the Digital Sending Network aren't encoded with any normal encoding; instead, they're encoded in a special Space Image Format. None of the Elves seem to remember why this is the case. They send you the instructions to decode it.

Images are sent as a series of digits that each represent the color of a single pixel. The digits fill each row of the image left-to-right, then move downward to the next row, filling rows top-to-bottom until every pixel of the image is filled.

Each image actually consists of a series of identically-sized layers that are filled in this way. So, the first digit corresponds to the top-left pixel of the first layer, the second digit corresponds to the pixel to the right of that on the same layer, and so on until the last digit, which corresponds to the bottom-right pixel of the last layer.

For example, given an image 3 pixels wide and 2 pixels tall, the image data 123456789012 corresponds to the following image layers:
```
Layer 1: 123
         456

Layer 2: 789
         012
```
 
 The image you received is 25 pixels wide and 6 pixels tall.

To make sure the image wasn't corrupted during transmission, the Elves would like you to find the layer that contains the fewest 0 digits. On that layer, what is the number of 1 digits multiplied by the number of 2 digits?

Your puzzle answer was 2520.

--- Part Two ---

Now you're ready to decode the image. The image is rendered by stacking the layers and aligning the pixels with the same positions in each layer. The digits indicate the color of the corresponding pixel: 0 is black, 1 is white, and 2 is transparent.

The layers are rendered with the first layer in front and the last layer in back. So, if a given position has a transparent pixel in the first and second layers, a black pixel in the third layer, and a white pixel in the fourth layer, the final image would have a black pixel at that position.

For example, given an image 2 pixels wide and 2 pixels tall, the image data 0222112222120000 corresponds to the following image layers:
```
Layer 1: 02
         22

Layer 2: 11
         22

Layer 3: 22
         12

Layer 4: 00
         00
```
 Then, the full image can be found by determining the top visible pixel in each position:

The top-left pixel is black because the top layer is 0.
The top-right pixel is white because the top layer is 2 (transparent), but the second layer is 1.
The bottom-left pixel is white because the top two layers are 2, but the third layer is 1.
The bottom-right pixel is black because the only visible pixel in that position is 0 (from layer 4).
So, the final image looks like this:
```
01
10
```

 What message is produced after decoding your image?

Your puzzle answer was LEGJY.
 
: [Next](@next)
*/
import Foundation

// this from Paul Hudson to split arrays into chunks!! 😬🙌
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
// a picture is made of layers
struct Layer {
    var width: Int
    var height: Int
    var data: [Int]
    func returnPixelValue(row: Int, col: Int) -> Int {
        return data[row * width + col]
    }
}
// I use a custom init. A picture is actually an array of layers
struct Picture {
    var layers: [Layer]
    init(data: [Int], width: Int, height: Int)  {
        layers = [Layer]()
        let pixelPerLayer = width * height
        let layerCount = data.count / pixelPerLayer
        // this is an array of layers!
        let dataPerLayer = data.chunked(into: pixelPerLayer)
        // split digits by layer
        for i in 0..<layerCount {
            // create a new layer and fill it with pixels
            layers.append(Layer(width: width, height: height, data: dataPerLayer[i]))
        }
    }
   
}
// this enum is because it looks good
enum Color: Int {
    case black = 0,
        white = 1,
        transparent = 2
}

// func getInput is in utilities file
var input = getInput(inputFile: "input8", extension: "txt")
let len = input.count
// had to filter because it did add a 0 at the end otherwise. I coalesce to -1 in map and take the -1 away in filter
var data = input.map { Int($0.string) ?? -1} // .filter { $0 != -1} this is kinda expensive so I will just take out the last element of the array this time!
//print(data)

let picture = Picture(data: data, width: 25, height: 6)

// this again is from Paul. my layer is mapped to a dict with keys 0, 1, 2 for the colors and value is the amount of them.
func getTheDigitsCount(data: [Int], digit: Int) -> Int {
    //convert data to an array of key-value pairs using tuples, where each value is the number 1:
    let mappedItems = data.map { ($0, 1) }
    // create a Dictionary from that tuple array, asking it to add the 1s together every time it finds a duplicate key:
    let counts = Dictionary(mappedItems, uniquingKeysWith: +)
    //That will create the dictionary ex [1: 1, 0: 2, 2: 1] because dictionaries are not stored in order – as you can see, it tells us that “0” appeared twice, while the other two appeared once.
    return counts[digit] ?? 0
}
// countzeroes is a tuple, well why not 😀👍🏻 it is like a dictionary, I stored the index with the number of zeroes
var countZeroes = (0,getTheDigitsCount(data: picture.layers[0].data, digit: 0))
// dropFirst allows me to safely iterate through layers droppint the first element
for (index,layer) in picture.layers.dropFirst().enumerated() {
    // countZeroes.1 is the second elem of my tuple, the first one is the index
    if countZeroes.1 > getTheDigitsCount(data: layer.data, digit: 0) {
        countZeroes = (index,getTheDigitsCount(data: layer.data, digit: 0))
    }
}
let layerWithFewestZeroes = countZeroes.0 + 1 // +1 because I dropped the first index
print("the layer with the fewest zeroes is \(countZeroes.0 + 1). Number of zeroes is \(countZeroes.1)")
let countOfOnes = getTheDigitsCount(data: picture.layers[layerWithFewestZeroes].data, digit: 1)
let countOfTwos = getTheDigitsCount(data: picture.layers[layerWithFewestZeroes].data, digit: 2)
// solution part one
print("The solution to part one is \(countOfOnes * countOfTwos)")

// -- part two ---

func mergeColors(_ colors: [Color]) -> Color {
    var next = colors[0]
    var idx = 0
    while .transparent == next && idx < colors.count {
        next = colors[idx]
        idx += 1
    }
    return next
}
var finaldata = [Color]()
var colors: [Color]
for row in 0..<6 {
    for col in 0..<25 {
        colors = picture.layers.map{Color(rawValue: ($0.returnPixelValue(row: row, col: col))) ?? .transparent }
        finaldata.append(mergeColors(colors))
    }
}

func printPicture(data: [Color]) {
    for i in 0..<6 {
        print("")
        for j in 0..<25 {
            switch data[i * 25 + j] {
            case .black: print("■", terminator: "" )
            case .white: print("❑", terminator: "")
            case .transparent: print(".", terminator: "")
            }
        }
    }
}
print("\nSolution to part two: ")
printPicture(data: finaldata)
