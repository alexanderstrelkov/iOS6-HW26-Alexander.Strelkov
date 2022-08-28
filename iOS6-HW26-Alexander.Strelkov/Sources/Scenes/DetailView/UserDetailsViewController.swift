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
    let datePicker = UIDatePicker()
    let genderPicker = UIPickerView()
    let genders = ["male", "female", "can't decide"]
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
        createDatePicker()
        createGenderPicker()
    }
    
    //MARK: -Functions:
    
    func createDatePicker() {
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date.now
        datePicker.addTarget(self,
                             action: #selector(dateChosen(datePicker:)),
                             for: UIControl.Event.valueChanged)
    }
    
    @objc private func dateChosen(datePicker: UIDatePicker) {
        dateTextField.text = datePicker.date.convertToString()
    }
    
    func createGenderPicker() {
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderTextField.inputView = genderPicker
        
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
            showAlert(title: "Cant save", message: "Fill in the information")
            return false
        }
        if user == nil {
            user = User()
        }
        if let user = user as? User {
            user.title = nameTextField.text
            user.date = dateTextField.text?.convertToDate()
            user.gender = genderTextField.text
            presenter?.updateUser(user, newName: nameTextField.text, date: dateTextField.text, gender: genderTextField.text)
            UserDataManager.instance.saveContext()
        }
        return true
    }
}

//MARK: -PickerViewDelegates:

extension UserDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
        genderTextField.resignFirstResponder()
    }
}

extension UserDetailsViewController: DetailUserViewProtocol {
    func setupTextFields() {
        if let user = user as? User {
            nameTextField.text = user.title
            dateTextField.text = user.date?.convertToString()
            genderTextField.text = user.gender
        }
    }
}
