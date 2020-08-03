//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Filipe Kertcher on 03/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation
import Domain

class AddAccountSpy : AddAccount {
    var addAccountModel : AddAccountModel?
    var completion : ((Result<AccountModel, DomainError>) -> Void)? = nil
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completeWithError(error:DomainError){
        completion?(.failure(error));
    }
    
    func completeWithAccount(account:AccountModel){
        completion?(.success(account));
    }
    
    
}
