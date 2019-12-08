public extension StringProtocol  {
    var digits: [Int] { compactMap{ $0.wholeNumberValue } }
}
public extension LosslessStringConvertible {
    var string: String { .init(self) }
}
public extension Numeric where Self: LosslessStringConvertible {
    var digits: [Int] { string.digits }
}
