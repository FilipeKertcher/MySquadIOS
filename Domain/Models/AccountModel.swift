//
//  AccountModel.swift
//  Domain
//
//  Created by Filipe Kertcher on 19/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

public struct AccountModel : Model {
    public var _id : String;
    public var name: String;
    public var email : String;
    public var socialMediaType: String;
    public var socialMediaToken: String;
    
    
    public init(_id:String,name:String,email:String,socialMediaType:String,token:String){
        self._id = _id
        self.name = name
        self.email = email
        self.socialMediaType = socialMediaType
        self.socialMediaToken = token
    }
}
