//
//  DashboardViewController.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/8/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import EightBase

class DashboardViewController: UITableViewController {
    
    var tables: [String] = [
        "brokers",
        "customers",
        "properties",
        "listings"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = tables[indexPath.row].capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table = tables[indexPath.row]
        
        self.performSegue(withIdentifier: table, sender: nil)
    }

}
