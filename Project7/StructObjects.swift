//
//  StructObjects.swift
//  Project7
//
//  Created by Mymac on 15/9/2022.
//

import Foundation


struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}


