//
//  UsersViewController.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 18.08.2022.
//

import Foundation
import UIKit
import CoreData

class UsersViewController: UIViewController {
    
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: UserDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    //MARK: -IBOutlets:
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pressButton: UIButton!
    
    @IBAction func textTypedField(_ sender: UITextField) {
        
    }
    
    //MARK: -IBActions:
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "\(self.textField.text ?? "") will be added", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Confirm", style: .default) { (action) in
            
            let newUser = User(context: UserDataManager.instance.context)

            newUser.title = self.textField.text ?? ""
            
            self.saveUsers()
            self.textField.text = ""
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: -viewDidLoad:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        fetchResultController.delegate = self
    }
   
    //MARK: -Methods
    
    func saveUsers() {
        do {
            try UserDataManager.instance.context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadUsers() {
        do {
            try fetchResultController.performFetch()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}

//MARK: -TableViewDelegate:

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath)
        let user = fetchResultController.object(at: indexPath) as! User
        cell.textLabel?.text = user.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = fetchResultController.object(at: indexPath) as! User
        performSegue(withIdentifier: "goToUserDetails", sender: user)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = fetchResultController.object(at: indexPath) as! User
            UserDataManager.instance.context.delete(user)
            UserDataManager.instance.saveContext()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUserDetails" {
            let destination = segue.destination as? UserDetailsViewController
            destination?.user = sender as? User
        }
    }
    
}

extension UsersViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .update:
            if let indexPath = indexPath {
                let user = fetchResultController.object(at: indexPath) as! User
                guard let cell = tableView.cellForRow(at: indexPath) else { break }
                cell.textLabel?.text = user.title
                tableView.reloadData()
            }
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}


