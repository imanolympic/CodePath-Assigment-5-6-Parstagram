//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Theron Mansilla on 10/23/20.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var submitImageButton: UIButton!
    @IBOutlet weak var imageCaptionTextField: UITextField!
    @IBAction func addImageButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func submitPostButtonPressed(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = imageCaptionTextField.text!
        post["author"] = PFUser.current()!
        
        let imageData = submitImageButton.image(for: .normal)?.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension CameraViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 400, height: 400)
        let scaledImage = image.af_imageScaled(to: size)
        
        submitImageButton.setImage(scaledImage, for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
