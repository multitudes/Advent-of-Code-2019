public enum TileType: Int {
    case empty = 0
    case wall
    case block
    case horizontalPaddle
    case ball
}

struct Coordinate: Hashable {
    let x: Int
    let y: Int
}

public struct Tile : Hashable {
    var coordinates: Coordinate
    var type: TileType
}

extension Tile: CustomStringConvertible {
    var description: String {
        switch self.type {
            case .empty: return "  "
            case .wall: return "⬜️"
            case .block: return "🟩"
            case .paddle: return "🟦"
            case .ball: return "🟣"
        }
    }
}

func draw(_ screen: [Coordinate: Tile], score: Int) {
    let xRange = screen.xRange
    let yRange = screen.yRange
    print("\u{001b}[H", terminator: "") // send the cursor home
    print("Score: \(score)")
    for y in yRange {
        for x in xRange {
            let pixel = screen[Coordinate(x: x, y: y), default: .empty]
            print(pixel, terminator: "")
        }
        print("")
    }
}
