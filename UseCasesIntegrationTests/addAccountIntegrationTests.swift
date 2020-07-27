//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Filipe Kertcher on 26/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {

    
    func test_add_account() {
        let url = URL(string: "https://run.mocky.io/v3/9225dcab-8656-4b89-b6d7-cb9eaac62a7a")!
        let client = AlamoFireAdapter()
        let sut = RemoteAddAccount(url: url, httpClient: client)
        let addAccountModel = AddAccountModel(name: "Filipe Kertcher", email: "TEste@tete.com", socialMediaType: "facebook", token: "123")
        
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel:addAccountModel) { result in
            switch(result){
            case .success(let account):
                XCTAssertNotNil(account._id)
                XCTAssertEqual(addAccountModel.name, account.name)
                XCTAssertEqual(addAccountModel.email, account.email)
                
            case .failure(let error): XCTFail("Expected success but got \(error) ")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5)
    }

     

}
