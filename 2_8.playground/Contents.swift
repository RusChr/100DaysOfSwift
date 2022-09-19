import UIKit

let result = "failure"
let result2 = "failed"
let result3 = "fail"


enum Results {
    case success
    case failure
}

let result4 = Results.failure

let result5: Results = .success
