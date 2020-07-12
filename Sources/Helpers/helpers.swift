public func appendChar(times: Int, char: String) -> String {
    var result: String = ""
    for _ in 0...times {
        result += char
    }
    return result
}
