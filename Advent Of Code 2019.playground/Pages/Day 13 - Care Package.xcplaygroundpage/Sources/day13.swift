public enum TileType: Int {
    case empty = 0
    case wall
    case block
    case paddle
    case ball
}

public struct Coordinate: Hashable {
    public let x: Int
    public let y: Int
    public init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
    static let zero = Coordinate(x: 0, y: 0)
}

public struct Tile : Hashable {
    public var coordinates: Coordinate
    public var type: TileType
    public init(coordinates: Coordinate, type: TileType){
        self.coordinates = coordinates
        self.type = type
    }
}

extension Tile: CustomStringConvertible {
    public var description: String {
        switch self.type {
            case .empty: return "  "
            case .wall: return "⬜️"
            case .block: return "🟩"
            case .paddle: return "🟦"
            case .ball: return "🟣"
        }
    }
}


extension Collection where Element: Comparable {
    public func range() -> ClosedRange<Element> {
        precondition(count > 0)
        let sorted = self.sorted()
        return sorted.first! ... sorted.last!
    }
}

extension Dictionary where Key == Coordinate {
    public var xRange: ClosedRange<Int> { keys.map { $0.x }.range() }
    public var yRange: ClosedRange<Int> { keys.map { $0.y }.range() }
}

