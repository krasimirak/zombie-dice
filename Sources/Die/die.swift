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
    
    let side = 0
    return currentDie.shuffled()[side]
}
