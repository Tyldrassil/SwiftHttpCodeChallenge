//
//  WikipediaJSON.swift
//  SwiftHttpChallenge
//
//  Created by Thomas Ditman on 27/01/2024.
//

import Foundation


struct EnclosingJSON : Codable {
    let parse: WikipediaJSON
}

struct WikipediaJSON : Codable {
    let title: String
    let pageid: Int
    let text: HtmlBody
}

struct HtmlBody : Codable {
    
    //Sneaky wikipedia uses an asterisk before giving the html data out, this uses codingkeys to make a custom name for the asterisk, since asterisks cannot be used as variable names
    enum CodingKeys: String, CodingKey {
        case text = "*"
    }
    
    let text: String
}
