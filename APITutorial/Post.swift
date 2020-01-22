//
//  Post.swift
//  APITutorial
//
//  Created by Morgan Davison on 1/22/20.
//  Copyright © 2020 Morgan Davison. All rights reserved.
//

import Foundation

struct Post: Codable {
    var id: Int
    var title: String
    var body: String
}
