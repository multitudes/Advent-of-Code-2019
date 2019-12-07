public struct Point: Hashable {
  public let x: Int
  public let y: Int
}

public func drawPath(path: inout [Point], wire: [(String, Int)]) {
    
    var positionX = 0
    var positionY = 0
    
    for i in 0..<wire.count {
        switch wire[i].0 {
        case "R":
            //print("R")
            //print(wire[i].1)
            for _ in 0..<wire[i].1 {
                positionX = positionX + 1
                path.append(Point(x: positionX, y: positionY))
            }
            
        case "L":
            //print("L")
            //print(wire[i].1)
            for _ in 0..<wire[i].1 {
                positionX = positionX - 1
                path.append(Point(x: positionX, y: positionY))
            }
        case "U":
            //print("U")
            //print(wire[i].1)
            for _ in 0..<wire[i].1 {
                positionY = positionY + 1
                path.append(Point(x: positionX, y: positionY))
            }
        case "D":
            //print("D")
            //print(wire[i].1)
            for _ in 0..<wire[i].1 {
                positionY = positionY - 1
                path.append(Point(x: positionX, y: positionY))
            }
            
        default:
            print("should not be possible!")
        }
        }
}
extension Array  {
    func contains<E1, E2>(_ tuple: (E1, E2)) -> Bool where E1: Equatable, E2: Equatable, Element == (E1, E2) {
        return contains { $0.0 == tuple.0 && $0.1 == tuple.1 }
    }
}

extension Array  {
    func contains<E1, E2>(_ tuple: (E1, E2)) -> Bool where E1: Equatable, E2: Equatable, Element == (x: E1, y: E2) {
        return contains { $0.0 == tuple.0 && $0.1 == tuple.1 }
    }
}
extension Array  {
    func contains<E1, E2>(_ tuple: (E1, E2)) -> Bool where E1: Hashable, E2: Hashable, Element == (x: E1, y: E2) {
        return contains { $0.0 == tuple.0 && $0.1 == tuple.1 }
    }
}
