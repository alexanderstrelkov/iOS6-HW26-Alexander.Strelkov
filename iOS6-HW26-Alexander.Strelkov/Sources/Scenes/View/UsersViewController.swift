//
//  UsersViewController.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 18.08.2022.
//

import Foundation
import UIKit

class UsersViewController: UIViewController {
    
    var usersArray = ["Alexander Strelkov", "Ivan Antipov"]
    
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var pressButton: UIButton!
    
    @IBAction func textTypedField(_ sender: UITextField) {
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "\(self.textField.text ?? "") will be added", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Confirm", style: .default) { (action) in
            print(self.textField.text ?? "")
            self.usersArray.append(self.textField.text ?? "")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath)
        
        cell.textLabel?.text = usersArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


