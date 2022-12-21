//
//  ViewController.swift
//  PickerControllerCreate
//
//  Created by Dilara Elçioğlu on 21.12.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UIFontPickerViewControllerDelegate{

    let photoView = UIImageView()
    let nameText = UITextField()
    let dateField = UITextField()
    let datePicker = UIDatePicker()
    let fontButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoView.image = UIImage(named: "ss")
        setUpUI()
        datePickerControl()
         
        //To Tap into ImageView
        let photoGesture = UITapGestureRecognizer(target: self, action: #selector(pickPhotoAction))
        photoView.isUserInteractionEnabled = true
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.addGestureRecognizer(photoGesture)

    }
    
    func setUpUI(){
        
        view.addSubview(photoView)
        view.addSubview(nameText)
        view.addSubview(dateField)
        view.addSubview(fontButton)
        
        
        photoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(280)
        }
        photoView.contentMode = UIView.ContentMode.scaleAspectFit
        
        nameText.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        nameText.placeholder = "Name"
        nameText.backgroundColor = .white
        nameText.borderStyle = .roundedRect
        nameText.textAlignment = .center
        
        dateField.snp.makeConstraints { make in
            make.top.equalTo(nameText.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        dateField.placeholder = "Birthday"
        dateField.backgroundColor = .white
        dateField.borderStyle = .roundedRect
        dateField.textAlignment = .center
        
        fontButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        fontButton.backgroundColor = .green
        fontButton.setTitle("Font", for: .normal)
        fontButton.layer.cornerRadius = 10
        fontButton.addTarget(self, action: #selector(changeFont), for: .touchUpInside)
    }
 
    
    //IMAGE PICKER
    @objc func pickPhotoAction(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    //To get photo from gallery and dismiss
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    //DATE PICKER
    func datePickerControl(){
        
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        dateField.inputView = datePicker
        dateField.inputAccessoryView = createToolBarForDate()
    }
    
    //DATE PICKER TOOL BAR
    func createToolBarForDate()-> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }
   
    @objc func donePressed1(){
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .none
        self.view.endEditing(true)
        dateField.text = dateFormater.string(from: datePicker.date)
    }
    
    //FONT PICKER
   
    @objc func changeFont(){
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = false
        let fontPicker = UIFontPickerViewController(configuration: config)
        fontPicker.delegate = self
        present(fontPicker, animated: true)
    }
  
    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true)
        guard let descriptor = viewController.selectedFontDescriptor else {return}
        nameText.font = UIFont(descriptor: descriptor, size: 24)
        
    }
    
}
