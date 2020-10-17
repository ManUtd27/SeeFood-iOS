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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    /// Handles when the camera is tapped
    /// - Parameter sender: The Nav bar item
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    }
}

//MARK: - Delegate methods for Image Picker and Navigation Controller
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
}

