//
//  ListingTableViewCell.swift
//  Example
//
//  Created by Vladyslav Vshevtsov on 1/10/19.
//  Copyright © 2019 8base. All rights reserved.
//

import UIKit
import Apollo

class ListingTableViewCell: UITableViewCell {
    var listingId: GraphQLID?
    
    @IBOutlet weak var brokerLabel: UILabel!
    @IBOutlet weak var buyerLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    func configure(with listing: ListingDetails) {
        listingId = listing.id
        
        brokerLabel?.text = (listing.broker?.user?.firstName ?? "Undefined") + " " + (listing.broker?.user?.lastName ?? "Undefined")
        buyerLabel?.text = (listing.buyer?.user?.firstName ?? "Undefined") + " " + (listing.buyer?.user?.lastName ?? "Undefined")
        sellerLabel?.text = (listing.seller?.user?.firstName ?? "Undefined") + " " + (listing.seller?.user?.lastName ?? "Undefined")
        statusLabel?.text = listing.status
        priceLabel?.text = String(listing.price ?? 0)
    }
    
}
