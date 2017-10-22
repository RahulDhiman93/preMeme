//
//  ViewController.swift
//  preMeme
//
//  Created by Rahul Dhiman on 15/10/17.
//  Copyright © 2017 Rahul Dhiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate{

    
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
 
    
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var shareIt: UIBarButtonItem!
    @IBOutlet weak var here: UITextField!
   
    
    @IBOutlet weak var imageView: UIImageView!
    
   
    
    let launch:UIImage = UIImage(named: "LaunchImage")!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if let _ = imageView.image {
            if imageView.image != launch{
                shareIt.isEnabled = true
                
            }
        } else {
            shareIt.isEnabled = false
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraButton.isEnabled = true
        }
        else{
            cameraButton.isEnabled = false
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
       
    }
    
    func customize(_ textField:UITextField)
    {
        textField.delegate = self
        textField.defaultTextAttributes = memeAttribute
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
       customize(type)
        customize(here)
        
        shareIt.isEnabled = false
        
    }
    
    func toolBarSet(_ cond:Bool){
        self.bottomBar.isHidden = cond
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
       
        
        view.frame.origin.y  -= getKeyboardHeight(notification)
    }
    
   
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
    }
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
      textField.text = ""
        
        if here.isEditing == true{
            subscribeToKeyboardNotifications()
            
        }
        else{
            unsubscribeFromKeyboardNotifications()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
       
    }

    let memeAttribute:[String:Any] = [NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
                                      NSAttributedStringKey.strokeWidth.rawValue : -2,
                                      NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
                                      NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!]
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
           imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
      
    }
    
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    func pickIT(_ source: UIImagePickerControllerSourceType){
    let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = source
        if source == .camera{
        pickController.cameraCaptureMode = .photo
            pickController.modalPresentationStyle = .fullScreen }
        self.present(pickController, animated: true,completion: nil)
    }
    
    @IBAction func picker(_ sender: Any) {
        
       pickIT(.photoLibrary)
}
    
    
    @IBAction func pickerCamera(_ sender: Any) {
        
                pickIT(.camera)
    }
    
   
    @IBAction func shareMAN(_ sender: Any) {
        
        let memedImage = generateMemedImage()
        
        let shareActivityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        shareActivityViewController.completionWithItemsHandler = { activity, completed, items, error in
            
            if completed {
                
                
                self.save(img: memedImage)
                
               
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        present(shareActivityViewController, animated: true, completion: nil)
        
    }
    
    func generateMemedImage() -> UIImage {
        
        
        toolBarSet(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        toolBarSet(false)
        return memedImage
    }
    
    func save(img: UIImage){
        let meme = Meme(topText: type.text!, bottomText: here.text!, orignalImage: img, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        let editor = storyboard!.instantiateViewController(withIdentifier: "start")
        present(editor, animated: true, completion: nil)
    }
    
    
}

