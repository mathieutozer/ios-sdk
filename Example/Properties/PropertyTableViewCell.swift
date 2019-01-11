//
//  PropertyTableViewCell.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/10/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import Apollo

class PropertyTableViewCell: UITableViewCell {
    var propertyId: GraphQLID?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bedroomsLabel: UILabel!

    func configure(with property: PropertyDetails) {
        propertyId = property.id
        
        titleLabel?.text = property.title
        descriptionLabel?.text = property.description
        bedroomsLabel?.text = String(property.bedrooms ?? 0)
    }
    
}
