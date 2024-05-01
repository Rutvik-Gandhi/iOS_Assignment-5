//
//  Image.swift
//  Assignment 5
//
//  Created by Assignment 5 on 23/11/22.
//

import Foundation

class Photo {
    var ID: String = ""
    var imageURL: String = ""
    var title: String = ""
    var description: String = ""

    init(id: String, imageURL: String, title: String, description: String) {
        self.ID = id
        self.imageURL = imageURL
        self.title = title
        self.description = description
    }
}
