//
//  UserDetailsViewController.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 20.08.2022.
//

import UIKit
import CoreData

class UserDetailsViewController: UIViewController {
    
    //MARK: -Attributes:
    
    var isEdit = false
    var user = UserDataManager.instance.user
    
    //MARK: -IBOutles:
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    //MARK: -IBActions:
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        toggleMode()
        if !isEdit {
            if saveUser() {
                let alert = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: -viewDidLoad:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableFields()
        setupFields()
    }
    
    //MARK: -Functions:
    
    func disableFields() {
        nameTextField.isEnabled = false
        genderTextField.isEnabled = false
        dateTextField.isEnabled = false
    }
    
    func toggleMode() {
        isEdit.toggle()
        editButton.title = isEdit ? "Save" : "Edit"
        nameTextField.isEnabled.toggle()
        dateTextField.isEnabled.toggle()
        genderTextField.isEnabled.toggle()
    }
    
    func setupFields() {
        if let user = user {
            nameTextField.text = user.title
            dateTextField.text = user.date?.convertToString()
            genderTextField.text = user.gender
        }
    }
    
    func saveUser() -> Bool {
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Can't save!", message: "No name typed, please fill in the information", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        }
        if let user = user {
            user.title = nameTextField.text
            user.date = dateTextField.text?.convertToDate()
            user.gender = genderTextField.text
            UserDataManager.instance.updateUser(user, newName: nameTextField.text, date: dateTextField.text, gender: genderTextField.text)
        }
        return true
    }
}

