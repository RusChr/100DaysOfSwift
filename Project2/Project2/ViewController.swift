//
//  ViewController.swift
//  Project2
//
//  Created by Rustam Chergizbiev on 9/1/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
    }
    
	
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        title = countries[correctAnswer].uppercased()
        title! += "   Score \(score)"
        questionCount += 1
    }
    
	
    @IBAction func buttonTapped(_ sender: UIButton) {
		UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
			sender.imageView?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
			sender.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
		} completion: { [unowned self] _ in
			var title: String
			
			if sender.tag == correctAnswer {
				title = "Correct"
				score += 1
				if score == 10 {
					showAlert(title: "WIN", message: "You are a winner!", actionTitle: "Start new game")
					score = 0
				} else {
					showAlert(title: title, message: "Your score is \(score)")
				}
			} else {
				title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
				score -= 1
				showAlert(title: title, message: "Your score is \(score)")
			}
			
			UIView.animate(withDuration: 1.5) {
				sender.layer.transform = CATransform3DMakeScale(1, 1, 1)
			}
		}
    }
    
	
    func showAlert(title: String, message: String, actionTitle: String = "Continue") {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
	
    @objc func showScore() {
        let ac = UIAlertController(title: "Score", message: "Score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Done", style: .default))
        present(ac, animated: true)
    }
    

}

