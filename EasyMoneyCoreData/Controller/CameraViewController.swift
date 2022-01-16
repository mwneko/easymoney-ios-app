//
//  CameraViewController.swift
//  EasyMoneyCoreData
//
//  Created by 庄文哲 on 30/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // link to the UI
    @IBOutlet weak var pictureOne: UIImageView!
    @IBOutlet weak var takePhotoOne: UIButton!
    @IBOutlet weak var selectPhotoOne: UIButton!
    @IBOutlet weak var nameOne: UILabel!
    @IBOutlet weak var studentNumberOne: UILabel!
    @IBOutlet weak var dutyOne: UILabel!
    
    @IBOutlet weak var pictureTwo: UIImageView!
    @IBOutlet weak var takePhotoTwo: UIButton!
    @IBOutlet weak var selectPhotoTwo: UIButton!
    @IBOutlet weak var nameTwo: UILabel!
    @IBOutlet weak var studentNumberTwo: UILabel!
    @IBOutlet weak var dutyTwo: UILabel!
    
    @IBOutlet weak var pictureThree: UIImageView!
    @IBOutlet weak var takePhotoThree: UIButton!
    @IBOutlet weak var selectPhotoThree: UIButton!
    @IBOutlet weak var nameThree: UILabel!
    @IBOutlet weak var studentNumberThree: UILabel!
    @IBOutlet weak var dutyThree: UILabel!
    
    // save which button has been clicked
    private var mark: Int = 0
    
    // set the 'ProfileViewModel' object
    private let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If the camera source (i.e. simulator) is not available, then
        // hide the take picture button.
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            takePhotoOne.isHidden = true
            takePhotoTwo.isHidden = true
            takePhotoThree.isHidden = true
        }
        
        /*
         1. set the button tag for mark which button call the 'selectPhoto' function
         2. set the select button function
         */
        selectPhotoOne.tag = 0
        selectPhotoOne.addTarget(self, action: #selector(selectPhoto), for: .touchDown)
        selectPhotoTwo.tag = 1
        selectPhotoTwo.addTarget(self, action: #selector(selectPhoto), for: .touchDown)
        selectPhotoThree.tag = 2
        selectPhotoThree.addTarget(self, action: #selector(selectPhoto), for: .touchDown)
        
        takePhotoOne.tag = 0
        takePhotoOne.addTarget(self, action: #selector(takePhoto), for: .touchDown)
        takePhotoTwo.tag = 1
        takePhotoTwo.addTarget(self, action: #selector(takePhoto), for: .touchDown)
        takePhotoThree.tag = 2
        takePhotoThree.addTarget(self, action: #selector(takePhoto), for: .touchDown)
        
        // set the student profile information
        let studentOne = profileViewModel.getStudentViewModel(index: 0)
        nameOne.text = studentOne.name!
        studentNumberOne.text = studentOne.studentNumber!
        dutyOne.text = studentOne.duty!
        if(studentOne.image != nil){
            pictureOne.image = studentOne.image!
        }
        
        let studentTwo = profileViewModel.getStudentViewModel(index: 1)
        nameTwo.text = studentTwo.name!
        studentNumberTwo.text = studentTwo.studentNumber!
        dutyTwo.text = studentTwo.duty!
        if(studentTwo.image != nil){
            pictureTwo.image = studentTwo.image!
        }
        
        let studentThree = profileViewModel.getStudentViewModel(index: 2)
        nameThree.text = studentThree.name!
        studentNumberThree.text = studentThree.studentNumber!
        dutyThree.text = studentThree.duty!
        if(studentThree.image != nil){
            pictureThree.image = studentThree.image!
        }
        
        // hide the add button
        self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
        self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // hide the add button
        self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
        self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
    }
    
    // the funtion of select picture
    @objc func selectPhoto(sender: UIButton){
        // update mark value
        self.mark = sender.tag
        
        // create 'UIImagePickerController' object
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // create select picutre from photos
    func pickPhotoFromSource(_ sourceType:UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            // Instantiate an image picker
            let picker = UIImagePickerController()
            
            // Allow taking a photo
            picker.sourceType = .camera
            
            // Set type can only choose camera, not video
            picker.cameraCaptureMode = .photo
            
            // controller and the navigation controller.
            picker.delegate = self
            
            // Is the user allowed to edit the media
            picker.allowsEditing = true
            picker.sourceType = sourceType
            
            // Present the picker to the user.
            present(picker, animated: true, completion: nil)
        }else{
            // Otherwise display an error message
            let alertController = UIAlertController(title:SystemMessage.cameraErrorTtitle.rawValue, message: SystemMessage.cameraErrorContent.rawValue, preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: SystemMessage.alertButton.rawValue, style: UIAlertAction.Style.cancel, handler: nil)
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func takePhoto(sender: UIButton){
        // update mark value
        self.mark = sender.tag
        pickPhotoFromSource(UIImagePickerController.SourceType.camera)
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil )
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image depend on 'mark'
        if(self.mark == 0){
            // set the image to UIImage view
            pictureOne.image = selectedImage
            
            // set the new image to core data
            let student = profileViewModel.getStudentViewModel(index: self.mark)
            student.setImage(editItem: student.studentProfile!, image: selectedImage)
        }else if(self.mark == 1){
            // set the image to UIImage view
            pictureTwo.image = selectedImage
            
            // set the new image to core data
            let student = profileViewModel.getStudentViewModel(index: self.mark)
            student.setImage(editItem: student.studentProfile!, image: selectedImage)
        }else{
            // set the image to UIImage view
            pictureThree.image = selectedImage
            
            // set the new image to core data
            let student = profileViewModel.getStudentViewModel(index: self.mark)
            student.setImage(editItem: student.studentProfile!, image: selectedImage)
        }
        
        // Dismiss the picker.
        self.dismiss(animated: true, completion: nil)
    }
}
