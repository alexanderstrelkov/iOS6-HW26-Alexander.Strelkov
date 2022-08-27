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
    var presenter: DetailUserPresenterProtocol?
    var user: AnyObject?
    
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
        setupTextFields()
    }
    
    //MARK: -Functions:
    
    func setupTextFields() {
        if let user = user as? User { // вью не должна знать о модели=( но так хотя бы работает
            nameTextField.text = user.title
            dateTextField.text = user.date?.convertToString()
            genderTextField.text = user.gender
        }
    }
    
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

    func saveUser() -> Bool {
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Can't save!", message: "No name typed, please fill in the information", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        }
//        if user == nil {
//            user = User()
//        }
//        if let user = presenter?.userToEdit {
//            user.title = nameTextField.text
//            user.date = dateTextField.text?.convertToDate()
//            user.gender = genderTextField.text
////            presenter?.updateUser(presenter?.userToEdit!, newName: <#T##String?#>, date: <#T##String?#>, gender: <#T##String?#>)
////        }
        return true
//    }
    }
}


