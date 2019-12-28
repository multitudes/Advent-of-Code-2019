//: [Previous](@previous)
/*:
# Day 13: Care Package

 [See it on github](https://github.com/multitudes/Advent-of-Code-2019)
   
As you ponder the solitude of space and the ever-increasing three-hour roundtrip for messages between you and Earth, you notice that the Space Mail Indicator Light is blinking. To help keep you sane, the Elves have sent you a care package.

It's a new game for the ship's arcade cabinet! Unfortunately, the arcade is all the way on the other end of the ship. Surely, it won't be hard to build your own - the care package even comes with schematics.

The arcade cabinet runs Intcode software like the game the Elves sent (your puzzle input). It has a primitive screen capable of drawing square tiles on a grid. The software draws tiles to the screen with output instructions: every three output instructions specify the x position (distance from the left), y position (distance from the top), and tile id. The tile id is interpreted as follows:

0 is an empty tile. No game object appears in this tile.
1 is a wall tile. Walls are indestructible barriers.
2 is a block tile. Blocks can be broken by the ball.
3 is a horizontal paddle tile. The paddle is indestructible.
4 is a ball tile. The ball moves diagonally and bounces off objects.
For example, a sequence of output values like 1,2,3,6,5,4 would draw a horizontal paddle tile (1 tile from the left and 2 tiles from the top) and a ball tile (6 tiles from the left and 5 tiles from the top).

Start the game. How many block tiles are on the screen when the game exits?

 ## Part 2
The game didn't run because you didn't put in any quarters. Unfortunately, you did not bring any quarters. Memory address 0 represents the number of quarters that have been inserted; set it to 2 to play for free.

The arcade cabinet has a joystick that can move left and right. The software reads the position of the joystick with input instructions:

If the joystick is in the neutral position, provide 0.
If the joystick is tilted to the left, provide -1.
If the joystick is tilted to the right, provide 1.
The arcade cabinet also has a segment display capable of showing a single number that represents the player's current score. When three output instructions specify X=-1, Y=0, the third output instruction is not a tile; the value instead specifies the new score to show in the segment display. For example, a sequence of output values like -1,0,12345 would show 12345 as the player's current score.

Beat the game by breaking all the blocks. What is your score after the last block is broken?
 
 Spoiler: I did not do it with printing on console because the playgrounds have a limited support for clear the screen and it would not look good enough and would take too much time at this stage. And I am doing the playground on the macos plattform. Still wuld be a nice project to make a visualisation for iOS one day!

 ### Day 13's winner #1: "untitled poem" by /u/tslater2006
 
They say that I'm fragile
But that simply can't be
When the ball comes forth
It bounces off me!
 
I send it on its way
Wherever that may be
longing for the time
that it comes back to me!
 
: [Next](@next)
*/

import Foundation

// func getInput is in utilities file
var input = getInput(inputFile: "input13", extension: "txt")
//get the input file as an array into program
var inputProgramArray = input.components(separatedBy: ",").compactMap { Int($0) }
// using the string extension  array
//var inputProgramArray = input.array(separatedBy: CharacterSet(arrayLiteral: ","),using: Int.init)
//print(inputProgramArray)
var progrLength = inputProgramArray.count
//print("length : \(progrLength)")
// when I load my program in memory it becomes a dict!
var program = Dictionary(uniqueKeysWithValues: zip(0..., inputProgramArray))

let arcadeTest = IntCodeComputer(program: program)

let outputs = arcadeTest.run()

var tiles = Set<Tile>()
for i in stride(from: 0, to: 3105, by: 3) {
    tiles.insert(Tile(coordinates: Coordinate(x: outputs[i], y: outputs[i + 1]), type: TileType(rawValue: outputs[i + 2])!))
    }
let blockCount = tiles.filter { $0.type == .block }.count
print("Solution part 1 is block count: \(blockCount)")

program[0] = 2
var arcadePlay = IntCodeComputer(program: program)

let outputsPlay = arcadePlay.run()



//do {
//    sleep(4)
//}

//print("\u{001B}")
print("\u{001b}")
