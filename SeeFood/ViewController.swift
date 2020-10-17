//
//  ViewController.swift
//  SeeFood
//
//  Created by Shawn Williams on 10/17/20.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

   
    @IBOutlet weak var imageView: UIImageView!
    
    // Get th image picker object
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the image picker delegate as self
        imagePicker.delegate = self
        // set the image picker source type
        imagePicker.sourceType = .camera
        // Set the image picker allows editting propery
        imagePicker.allowsEditing = false
        
    }
    
    
    /// Handles when the camera is tapped
    /// - Parameter sender: The Nav bar item
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        // Presents the impage picker object when the camera button is pressed
        present(imagePicker, animated: true, completion: nil)
    }
}

//MARK: - Delegate methods for Image Picker
extension ViewController: UIImagePickerControllerDelegate {
    
    
    /// Handles the logic when the user did finish picking a image or media with info
    /// - Parameters:
    ///   - picker: The current UI Picker
    ///   - info: Info about the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image that user picked from the image picker
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Set that picked image as the image in the imageView
            imageView.image = userPickedImage
        }
        // Dismiss the image picker after the selection
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Delegat methods for Navigation Controller
extension ViewController: UINavigationControllerDelegate {
    
}

