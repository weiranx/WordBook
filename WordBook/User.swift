//
//  User.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import Foundation

class User {
    
    // MARK: Private Instance
    
    var username: String
    var password: String
    
    var authorizedStatus: Bool?
    
    var wordListsSerialNum: [Int]?
    
    // MARK: Init methods
    
    init(inputUsername: String, inputPassword: String) {
        username = inputUsername
        password = inputPassword
    }
    
    // MARK: Methods
    
    func userLogin() -> AuthorizedUser? {
        
        // logic for prechecking user crenditials (i.e. length of username and password)

        
       return AuthorizedUser.authorizeUser(self) ?? nil
        
    }
    
    
    
    
    
}
