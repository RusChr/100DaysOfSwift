//
//  DetailViewController.swift
//  Day50ChallengeProject
//
//  Created by Rustam Chergizbiev on 9/26/22.
//

import UIKit

class DetailViewController: UIViewController {
	
	@IBOutlet var imageView: UIImageView!
	
	var imageURL: URL?
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let url = imageURL {
			imageView.image = UIImage(contentsOfFile: url.path())
		}
    }

}
