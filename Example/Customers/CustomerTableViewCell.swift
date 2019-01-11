//
//  CustomerTableViewCell.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/10/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import Apollo

class CustomerTableViewCell: UITableViewCell {
    var customerId: GraphQLID?
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var purchasesLabel: UILabel!
    @IBOutlet weak var salesLabel: UILabel!

    func configure(with customer: CustomerDetails) {
        customerId = customer.user?.id
        
        firstNameLabel?.text = customer.user?.firstName
        lastNameLabel?.text = customer.user?.lastName
        purchasesLabel?.text = String(customer.purchases?.count ?? 0)
        salesLabel?.text = String(customer.sales?.count ?? 0)
    }
    
}
