//
//  ViewController.swift
//  Day41ChallengeProject
//
//  Created by Rustam Chergizbiev on 9/15/22.
//

import UIKit

class ViewController: UIViewController {
	
	var word = ""
	var promptWord = ""
	var allWords = [String]()
	var usedLetters = [String]()
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "????????"
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New game", style: .plain, target: self, action: #selector(startGame))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
		
		if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let startWord = try? String(contentsOf: startWordsURL) {
				allWords = startWord.components(separatedBy: "\n")
			}
		}
		
		startGame()
	}

	
	@objc func startGame() {
		usedLetters.removeAll()
		word = allWords.randomElement() ?? "empty"
		
		print(word)
		print(promptWord)
	}
	
	
	@objc func promptForAnswer() {
		let ac = UIAlertController(title: "Enter a letter", message: nil, preferredStyle: .alert)
		ac.addTextField()
		
		let addAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
			guard let answer = ac?.textFields?[0].text else { return }
			self?.submit(answer: answer)
		}
		
		ac.addAction(addAction)
		present(ac, animated: true)
	}
	
	
	func submit(answer: String) {
		promptWord = ""
		
		if answer.isEmpty {
			return
		} else if answer.count == 1 {
			usedLetters.append(answer)
		} else {
			promptForAnswer()
		}
		
		for letter in word {
			let strLetter = String(letter)
			
			if usedLetters.contains(strLetter) {
				promptWord += strLetter
			} else {
				promptWord += "?"
			}
		}
		
		title = promptWord
		
		if promptWord == word {
			let ac = UIAlertController(title: "Congratulations!", message: "You guessed the word", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "Ok", style: .default))
			present(ac, animated: true)
		}
	}
}

