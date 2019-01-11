//
//  BrokersViewController.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/10/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import EightBase
import Apollo

class BrokersViewController: UITableViewController {
    var brokersList: [AllBrokersQuery.Data.BrokersList.Item]? {
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

    var watcher: GraphQLQueryWatcher<AllBrokersQuery>?

    func loadData() {
        watcher = EightBase.Apollo?.watch(query: AllBrokersQuery()) { (result, error) in
            if let error = error {
                NSLog("Error while fetching query: \(error.localizedDescription)")
                return
            }

            self.brokersList = result?.data?.brokersList.items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brokersList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BrokerTableViewCell else {
            fatalError("Could not dequeue BrokerTableViewCell")
        }

        guard let broker = brokersList?[indexPath.row] else {
            fatalError("Could not find customer at row \(indexPath.row)")
        }

        cell.configure(with: broker.fragments.brokerDetails)

        return cell
    }
}
