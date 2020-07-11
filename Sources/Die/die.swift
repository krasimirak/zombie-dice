public enum Die: String {
    case green = "green"
    case yellow = "yellow"
    case red = "red"
}

public let greenDie = ["🧠", "🧠", "🧠", "👣", "👣", "💥"]
public let yellowDie = ["🧠", "🧠", "👣", "👣", "💥", "💥"]
public let redDie = ["🧠", "👣", "👣", "💥", "💥", "💥"]

public func rollADie(die: Die) -> String {
    var currentDie: [String]

    switch die {
    case .green:
        currentDie = greenDie
    case .yellow:
        currentDie = yellowDie
    case .red:
        currentDie = redDie
    }
    
    let side = Int.random(in: 1...6) // choose a side from the 6 available
    return currentDie.shuffled()[side - 1] // indexes from 0 to 5
}
