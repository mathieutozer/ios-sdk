//
//  BrokerTableViewCell.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/10/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import Apollo

class BrokerTableViewCell: UITableViewCell {
    var brokerId: GraphQLID?
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    func configure(with broker: BrokerDetails) {
        brokerId = broker.user?.id
        
        firstNameLabel?.text = broker.user?.firstName
        lastNameLabel?.text = broker.user?.lastName
        emailLabel?.text = broker.user?.email
    }
    
}
