import UIKit

enum Activity {
    case bored
    case running
    case talking
    case singing
}

enum AssocActivity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = AssocActivity.talking(topic: "football")


enum Weather {
    case sunny
    case windy(speed: Int)
    case rainy(chance: Int, amount: Int)
}
