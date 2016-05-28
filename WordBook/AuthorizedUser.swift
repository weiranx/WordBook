//
//  AuthorizedUser.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import Foundation

class AuthorizedUser: User {
    
    
    // MARK: Init Methods
    
    private init?(user: User) {
        
        super.init(inputUsername: user.username, inputPassword: user.password)
        authorizedStatus = true
    }
    
    // MARK: Static Methods
    
    class func authorizeUser(user: User) -> AuthorizedUser? {
        
        // logic for checking user's authentication and return a AuthorizedUser when authencated, else return nil
        
        return AuthorizedUser(user: user) ?? nil
        
    }
}