//
//  GettingStartedVC.swift
//  BornToughTrainer
//
//  Created by admin on 14/07/2018.
//  Copyright © 2018 MAQ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GettingStartedVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let white = "Clicking Sign Up means that you agree to the"
    let Green1 = "Terms & Conditions"
    let Green2 = "Privacy Policy"
    let and = "and"
    
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var levelTextField: textFieldClass!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: textFieldClass!
    
    @IBOutlet weak var mobileTextField: textFieldClass!
    @IBOutlet weak var teamTextField: textFieldClass!
    @IBOutlet weak var genderTextField: textFieldClass!
    @IBOutlet weak var sportTextField: textFieldClass!
    
    
    var pickerView = UIPickerView()
    let levelArray = ["","Professional","Olympic","College","High School", "Middle School","Youth","Other"]
    let Gender = ["","Male", "Female"]
    let Category = ["","Team","School","Club","Academy"]
    
    var selectedProfileImage : UIImage?
    var imageMetaData = ""
    var userName : String?
    
    
    
    var dbRef : DatabaseReference!

    let storage = Storage.storage()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Multi Color String
        let stringValue = "\(self.white)\n\(self.Green1) \(and) \(Green2)"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColor(color: UIColor.white, forText: white)
        attributedString.setColor(color: UIColor.green, forText: Green1)
        attributedString.setColor(color: UIColor.white, forText: and)
        attributedString.setColor(color: UIColor.green, forText: Green2)
        termLabel.font = UIFont.systemFont(ofSize: 15)
        termLabel.attributedText = attributedString
        
        // imageView Rounded
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.masksToBounds = true
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.layer.borderWidth = 5
        self.profileImage.layer.borderColor = UIColor.white.cgColor

        
        
//        self.nameTextField.text = userName!
        self.nameTextField.text = userName!

        
        // PickerView
        
    pickerView.delegate = self
    pickerView.dataSource = self
    self.levelTextField.delegate = self
    self.genderTextField.delegate =  self
    self.teamTextField.delegate = self
        
        
        // image tapped
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SetProfile))
        self.profileImage.isUserInteractionEnabled = true
        self.profileImage.addGestureRecognizer(tap)
    }
    
    @objc func SetProfile(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let selectedImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
    
        
        self.profileImage.image = selectedImage
        
        self.selectedProfileImage = selectedImage
        
        dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func getStartedAction(_ sender: Any) {
        
        if profileImage.image != UIImage(named: "Rectangle Copy"){
            
            if (nameTextField.text?.isEmpty != true) && (sportTextField.text?.isEmpty != true) && (levelTextField.text?.isEmpty != true) && (genderTextField.text?.isEmpty != true) && (teamTextField.text?.isEmpty != true) && (mobileTextField.text?.isEmpty != true) {
                
//                print("***********************")
//                print(nameTextField.text)
//                print(sportTextField.text)
//                print(levelTextField.text)
//                print(genderTextField.text)
//                print(teamTextField.text)
//                print(mobileTextField.text)
                print("***********************")
                
                var userInfo = [ "Name": nameTextField.text!,
                               "Sport": sportTextField.text!,
                               "Level": levelTextField.text!,
                               "Gender": genderTextField.text!,
                               "Team": teamTextField.text!,
                               "Mobile": mobileTextField.text!,
                               "Image-URL" :"",
                               "Email": (Auth.auth().currentUser?.email)!,
                               "Identify-Create" : "no"
                ]
                
                
                var imageData = Data()
                
//                print(selectedProfileImage)
                
                imageData  = UIImageJPEGRepresentation(self.selectedProfileImage!, 0.7)!
                
                let StorageRef = self.storage.reference().child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("Profile_Image")
                
                let uploadMetaData = StorageMetadata()
                uploadMetaData.contentType = "image/jpeg"
                
                StorageRef.putData(imageData, metadata: uploadMetaData) { (metaData, meta_error) in


                 



                    if meta_error != nil{

                        let alert = UIAlertController(title: "ERROR!", message: meta_error?.localizedDescription, preferredStyle: .alert)

                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        
                        alert.addAction(action)

                        self.present(alert, animated: true, completion: nil)


                    }


                    else{

                        

                        userInfo["uID"] = (Auth.auth().currentUser?.uid)!
//                        userInfo["Image"] = (metaData?.downloadURL()?.description)!
                        
                        StorageRef.downloadURL(completion: { (image_URl, error) in
//                            print(image_URl?.absoluteString)
                            
                            userInfo["Image-URL"] = (image_URl?.absoluteString)!
                            self.dbRef = Database.database().reference()
                            
                            self.dbRef.child("User").child((Auth.auth().currentUser?.uid)!).setValue(userInfo)
                        })

                       let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HOME")
                        self.present(homeVC!, animated: true, completion: nil)
                    }
                }

                
               
                
                
                
            }
                
            else{
                alertWindow(alertTitle: "Data Missing", alertMessage: "Some of the textfield are empty")
            }
        }
            
            
        else {
            alertWindow(alertTitle: "Image Missing", alertMessage: "Please place desire profile image")
        }
        
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if textField == self.levelTextField{
            self.pickerView.tag = 0
            self.levelTextField.inputView = self.pickerView
            self.pickerView.reloadAllComponents()
        }
        
        else if textField == self.genderTextField{
            self.pickerView.tag = 1
            self.genderTextField.inputView = self.pickerView
            self.pickerView.reloadAllComponents()
        }
        
        else if textField == self.teamTextField{
            self.pickerView.tag = 2
            self.teamTextField.inputView = self.pickerView
            self.pickerView.reloadAllComponents()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.levelTextField{
            self.pickerView.tag = 0
            self.levelTextField.inputView = nil
            self.pickerView.reloadAllComponents()
        }
            
        else if textField == self.genderTextField{
            self.pickerView.tag = 1
            self.genderTextField.inputView = nil
            self.pickerView.reloadAllComponents()
        }
            
        else if textField == self.teamTextField{
            self.pickerView.tag = 2
            self.teamTextField.inputView = nil
            self.pickerView.reloadAllComponents()
        }

    }
    
    
    // PickerView related functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return levelArray.count
        }
        else if pickerView.tag == 1 {
            return Gender.count
        }
        
        else {
            return Category.count
        }
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return levelArray[row]
        }
        else if pickerView.tag == 1{
            return Gender[row]
        }
        else {
            return Category[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            self.levelTextField.text = levelArray[row]
        }
        else if pickerView.tag == 1{
            self.genderTextField.text = Gender[row]
        }
        else {
            self.teamTextField.text = Category[row]
        }
    }
    
    
    // Function that will management Alert ViewController
    func alertWindow(alertTitle: String, alertMessage: String){
        
        let AlertVC = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        AlertVC.addAction(alertAction)
        self.present(AlertVC, animated: true, completion: nil)
    }
    
}






extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
    
}
