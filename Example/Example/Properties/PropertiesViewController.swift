//
//  PropertiesViewController.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/10/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import EightBase
import Apollo
import JGProgressHUD

class PropertiesViewController: UITableViewController {
    let hud = JGProgressHUD(style: .dark)

    var propertiesList: [AllPropertiesQuery.Data.PropertiesList.Item]? {
        didSet {
            tableView.reloadData()
            hud.dismiss()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        
        hud.show(in: self.view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData()
    }

    var watcher: GraphQLQueryWatcher<AllPropertiesQuery>?

    func loadData() {
        watcher = EightBase.Apollo?.watch(query: AllPropertiesQuery()) { (result, error) in
            if let error = error {
                NSLog("Error while fetching query: \(error.localizedDescription)")
                return
            }

            self.propertiesList = result?.data?.propertiesList.items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertiesList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PropertyTableViewCell else {
            fatalError("Could not dequeue PropertyTableViewCell")
        }

        guard let property = propertiesList?[indexPath.row] else {
            fatalError("Could not find Property at row \(indexPath.row)")
        }

        cell.configure(with: property.fragments.propertyDetails)

        return cell
    }
}
