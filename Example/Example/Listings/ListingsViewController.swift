//
//  ListingsViewController.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/10/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import EightBase
import Apollo
import JGProgressHUD

class ListingsViewController: UITableViewController {
    let hud = JGProgressHUD(style: .dark)

    var listingsList: [AllListingQuery.Data.ListingsList.Item]? {
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

    var watcher: GraphQLQueryWatcher<AllListingQuery>?

    func loadData() {
        watcher = EightBase.Apollo?.watch(query: AllListingQuery()) { (result, error) in
            if let error = error {
                NSLog("Error while fetching query: \(error.localizedDescription)")
                return
            }

            self.listingsList = result?.data?.listingsList.items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingsList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListingTableViewCell else {
            fatalError("Could not dequeue ListingTableViewCell")
        }

        guard let listing = listingsList?[indexPath.row] else {
            fatalError("Could not find listing at row \(indexPath.row)")
        }

        cell.configure(with: listing.fragments.listingDetails)

        return cell
    }
}
