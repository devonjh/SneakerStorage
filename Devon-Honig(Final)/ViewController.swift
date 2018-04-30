//
//  ViewController.swift
//  Devon-Honig(Final)
//
//  Created by Devon Honig on 4/4/18.
//  Copyright © 2018 Devon Honig. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let dateFormatter = DateFormatter()
    var cancelled: Bool = true
    let defaultImage = UIImage(named: "defaultSneaker.jpg")
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var styleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var pairImageView: UIImageView!
    
    @IBAction func changePic(_ sender: Any) {
        getImageFromLibrary()
    }
    
    @objc func cancelTapped(_ sender: UIBarButtonItem) {
        cancelled = true
        performSegue(withIdentifier: "unwindFromAddPair", sender: self)
    }
    
    @objc func saveTapped(_ sender: UIBarButtonItem) {
        cancelled = false
        performSegue(withIdentifier: "unwindFromAddPair", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        dateFormatter.dateFormat = "MM/dd/yyyy"
        brandTextField.delegate = self
        styleTextField.delegate = self
        priceTextField.delegate = self
        brandTextField.text = ""
        styleTextField.text = ""
        priceTextField.text = ""
        pairImageView.image = defaultImage
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Method to populate the brandPicker. Call in viewDidLoad()
    func getImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Library unavailable")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("image picker finished")
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.pairImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.pairImageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image picker cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    


}

