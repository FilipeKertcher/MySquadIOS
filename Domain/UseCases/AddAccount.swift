//
//  AddAccount.swift
//  Domain
//
//  Created by Filipe Kertcher on 19/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

public struct AddAccountModel: Model {
    public var name: String;
    public var email : String;
    public var socialMediaType: String;
    public var socialMediaToken: String;
    
    public init(name:String,email:String,socialMediaType:String,token:String){
        self.name = name
        self.email = email
        self.socialMediaType = socialMediaType
        self.socialMediaToken = token
    }
}

public protocol AddAccount{
    func add(addAccountModel:AddAccountModel,completion: @escaping (Result<AccountModel,DomainError>) -> Void)
}


