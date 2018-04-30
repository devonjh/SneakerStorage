//
//  Pair.swift
//  Devon-Honig(Final)
//
//  Created by Devon Honig on 4/29/18.
//  Copyright © 2018 Devon Honig. All rights reserved.
//

import Foundation

class Pair {
    var brandName: String
    var styleName: String
    var date: Date
    var price: Double
    var imageFileName: String?
    
    init() {
        brandName = ""
        styleName = ""
        date = Date()
        price = 0.0
    }
}
