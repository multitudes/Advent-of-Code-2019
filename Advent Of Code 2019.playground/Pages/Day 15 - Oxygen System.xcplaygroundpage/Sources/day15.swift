public struct Coordinate: Hashable {
    public let x: Int
    public let y: Int
    public init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
    public static let zero = Coordinate(x: 0, y: 0)
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

