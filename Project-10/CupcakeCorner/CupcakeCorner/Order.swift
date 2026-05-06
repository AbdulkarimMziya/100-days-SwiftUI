//
//  Order.swift
//  CupcakeCorner
//
//  Created by Abdulkarim Mziya on 2026-05-04.
//

import Foundation

@Observable
class Order {
    static let types = ["Strawberry","Vanilla", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    // MARK: Properties for Address
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if !name.isEmpty || !streetAddress.isEmpty || !city.isEmpty || !zip.isEmpty {
            return true
        }
        return false
    }
    
    
    // MARK: Properties for checkout
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity) / 2
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}

