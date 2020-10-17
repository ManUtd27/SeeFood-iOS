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
        //        imagePicker.sourceType = .photoLibrary
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
            
            // Convert the user Picked image to a CiImage which allows proccessing by CoreML and Vision
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage")
            }
            // Call the detect function using our cIImage
            detect(image: ciImage)
            
        }
        // Dismiss the image picker after the selection
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    /// Handles the dectection for the image Using the CoreML Model
    /// - Parameter image: The converted userpicked image
    func detect(image: CIImage) {
            // Create a model using the InceptionV3 model in file path
        guard let model =  try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model Failed")
        }
        
        // Create a request to Vision using a request and the model
        let request = VNCoreMLRequest(model: model) { (request, error) in
            // Get the request results as an array of VNClassificationObservation
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model Failed to process the image")
            }
            
           // Check the first item in the results array with the highest confidence rating percentage
            if let firstResults = results.first {
                if firstResults.identifier.contains("hotdog") {
                    self.setNavBarTitle(title: "Hotdog!")
                } else {
                    self.setNavBarTitle(title: "Not Hotdog!")
                }
            }
            
        }
        // Create a handler that helps specify the image we want to perform the ML request on
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            // Try and perform request using the handler
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
}

//MARK: - Delegat methods for Navigation Controller
extension ViewController: UINavigationControllerDelegate {
    
    /// Handles the ML logic for setting the navbar title
    /// - Parameter title: its either a hot dog or not!
    func setNavBarTitle(title: String)  {
        self.navigationItem.title = title
    }
}

