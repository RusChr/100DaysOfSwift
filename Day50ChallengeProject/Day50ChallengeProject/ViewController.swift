//
//  ViewController.swift
//  Day50ChallengeProject
//
//  Created by Rustam Chergizbiev on 9/26/22.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var photos = [Photo]()

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takePhoto))
		
		let defaults = UserDefaults.standard
		if let savedPhotos = defaults.object(forKey: "photos") as? Data {
			let jsonDecoder = JSONDecoder()
			do {
				photos = try jsonDecoder.decode([Photo].self, from: savedPhotos)
			} catch {
				print("Failed to load photos.")
			}
		}
	}
	
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		guard let image = info[.editedImage] as? UIImage else { return }
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMddyyyyHHmmss"
		
		let imageName = dateFormatter.string(from: Date())
		print(imageName)
		let imagePath = getDocumentsDirectory().appending(path: imageName)
		
		if let jpegData = image.jpegData(compressionQuality: 0.8) {
			try? jpegData.write(to: imagePath)
		}
		
		let photo = Photo(name: imageName, image: imageName)
		photos.append(photo)
		
		tableView.reloadData()
		
		dismiss(animated: true)
		
		save()
	}
	
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	
	@objc func takePhoto() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			picker.sourceType = .camera
		}
		
		present(picker, animated: true)
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return photos.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let photo = photos[indexPath.row]
		cell.textLabel?.text = photo.name
		
		return cell
	}
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			let photo = photos[indexPath.row]
			let path = getDocumentsDirectory().appending(path: photo.image)
			vc.imageURL = path
			navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	
	func save() {
		let jsonEncoder = JSONEncoder()
		if let savedData = try? jsonEncoder.encode(photos) {
			let defaults = UserDefaults.standard
			defaults.set(savedData, forKey: "photos")
		} else {
			print("Failed to save photos.")
		}
	}
}

