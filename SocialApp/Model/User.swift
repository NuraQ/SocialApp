//
//  User.swift
//  SocialApp
//
//  Created by Asal 3 on 25/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import Foundation

struct User:Codable {
//  var userName: String?
//  var email: String?
//  var phoneNumber: String?
//  var webSite: String?
    public let name: String
       public let id: Int
       public let username: String
       public let email: String
       public let website: String
       public let phone: String
       public let company: company
       public let address: address


}
struct company: Codable {
    public let name: String
    public let catchPhrase: String
    public let bs: String
    
}

struct address: Codable {
    public let street: String
    public let zipcode: String
    public let suite: String
    public let city: String
    public let geo: geo

    
}

struct geo: Codable {
    public let lat: Int
    public let lng: Int
}

