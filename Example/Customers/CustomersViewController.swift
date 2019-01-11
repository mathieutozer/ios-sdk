//
//  CustomersViewController.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/10/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import EightBase
import Apollo

class CustomersViewController: UITableViewController {
    var customersList: [AllCustomersQuery.Data.CustomersList.Item]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData()
    }

    var watcher: GraphQLQueryWatcher<AllCustomersQuery>?

    func loadData() {
        watcher = EightBase.Apollo?.watch(query: AllCustomersQuery()) { (result, error) in
            if let error = error {
                NSLog("Error while fetching query: \(error.localizedDescription)")
                return
            }

            self.customersList = result?.data?.customersList.items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customersList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomerTableViewCell else {
            fatalError("Could not dequeue CustomerTableViewCell")
        }

        guard let customer = customersList?[indexPath.row] else {
            fatalError("Could not find customer at row \(indexPath.row)")
        }

        cell.configure(with: customer.fragments.customerDetails)

        return cell
    }
}
