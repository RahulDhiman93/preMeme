//
//  ViewController.swift
//  preMeme
//
//  Created by Rahul Dhiman on 15/10/17.
//  Copyright © 2017 Rahul Dhiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate{

    
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var here: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       type.delegate = self
        here.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      textField.text = ""
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
           imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func picker(_ sender: Any) {
        
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = .photoLibrary
        self.present(pickController, animated: true,completion: nil)
        
    }
    
    
    
    @IBAction func pickerCamera(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = .camera
        pickController.cameraCaptureMode = .photo
        pickController.modalPresentationStyle = .fullScreen
        
        self.present(pickController, animated: true,completion: nil)
    }
        else{
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .alert)
        
        present(
            alertVC,
            animated: true,
            completion: nil)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}

