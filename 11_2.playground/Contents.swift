import UIKit

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}


protocol Employee: Payable, NeedsTraining, HasVacation {
    
}

class Employees: Employee {
    func calculateWages() -> Int {
        return 52
    }
    
    func study() {
        print("study")
    }
    
    func takeVacation(days: Int) {
        print("take \(days) days for vacation")
    }
}

let employee = Employees()
employee.calculateWages()
employee.study()
employee.takeVacation(days: 28)
