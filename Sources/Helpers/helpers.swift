public func appendChar<T: LosslessStringConvertible>(times: Int, char: T) -> String {
    var result: String = ""
    for _ in 0...times {
        result += String(char)
    }
    return result
}
