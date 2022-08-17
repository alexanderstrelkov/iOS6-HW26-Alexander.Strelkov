//
//  ViewController.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 15.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

}

