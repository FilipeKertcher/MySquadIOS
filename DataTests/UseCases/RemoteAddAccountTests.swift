    //
    //  DataTests.swift
    //  DataTests
    //
    //  Created by Filipe Kertcher on 19/07/20.
    //  Copyright © 2020 Filipe Kertcher. All rights reserved.
    //
    
    import XCTest
    import Domain
    @testable import Data
    
    class RemoteAddAccountTests: XCTestCase {
        
        func test_add_should_call_httpclient_with_correct_url () {
            let testURL = makeURL()
            let (sut,httpClientSpy) = makeSut(url: testURL)
            
            sut.add(addAccountModel:makeAddAccountModel()) { _ in }
            XCTAssertEqual(httpClientSpy.url,testURL)
        }
        
        
        func test_add_should_call_httpclient_with_correct_data () {
            let (sut,httpClientSpy) = makeSut()
            let addAccountModel = makeAddAccountModel()
            
            sut.add(addAccountModel:addAccountModel) { _ in  }
            
            XCTAssertEqual(httpClientSpy.data,addAccountModel.toData())
        }
        
        func test_add_should_complete_if_client_fails () {
            let (sut,httpClientSpy) = makeSut()
            
            expect(sut, completeWith: .failure(.unexpected), when: {
                httpClientSpy.completeWithError(.noConnectivity)
            })
            
        }
        
        func test_add_should_complete_if_client_completes_with_valid_data () {
            let (sut,httpClientSpy) = makeSut()
            let expectedAccount = makeAccountModel()
            expect(sut, completeWith: .success(expectedAccount), when: {
                httpClientSpy.completeWithData(expectedAccount.toData()!)
            })
        }
        
        func test_add_should_complete_if_client_completes_with_invalid_data () {
            let (sut,httpClientSpy) = makeSut()
            expect(sut, completeWith: .failure(.unexpected), when: {
                httpClientSpy.completeWithData(makeInvalidData())
            })
        }
        
        func should_not_complete_if_sut_has_been_deallocated () {
            let httpClientSpy = HttpClientSpy()
            var sut : RemoteAddAccount? = RemoteAddAccount(url:makeURL(), httpClient: httpClientSpy)
            var result : Result<AccountModel,DomainError>?
            sut?.add(addAccountModel: makeAddAccountModel()) { result = $0 }
            sut = nil
            httpClientSpy.completeWithError(.noConnectivity)
            
            XCTAssertNil(result)
        }
    }
    
    
    
    
    extension RemoteAddAccountTests {
        
       
        
        func makeAddAccountModel()  -> AddAccountModel {
            return AddAccountModel(name: "Filipe Kertcher", email: "filipekertcher97@gmail.com", socialMediaType: "FACEBOOK", token: "123456")
        }
        
       
        
        func expect(_ sut:RemoteAddAccount, completeWith expectedResult: Result<AccountModel,DomainError>, when action: () -> Void,file:StaticString = #file, line: UInt = #line){
            
            
            let exp = expectation(description:"waiting")
            
            sut.add(addAccountModel:makeAddAccountModel()) {receivedResult in
                
                switch(expectedResult, receivedResult) {
                case (.failure(let expectedError),.failure(let receivedError)):  XCTAssertEqual(expectedError,receivedError,file:file,line:line);
                    
                case (.success(let expectedAccount),.success(let receivedAccount)):  XCTAssertEqual(expectedAccount,receivedAccount,file:file,line:line);
                    
                default: XCTFail("Expected Success and received Error",file:file,line:line);
                    
                }
                
                exp.fulfill()
            }
            
            action()
            
            wait(for:[exp],timeout:1)
        }
        
        func makeSut(url: URL = URL(string:"http://localhost:3000")!) -> (sut: RemoteAddAccount, httpClientSpy:HttpClientSpy) {
            
            let httpClientSpy = HttpClientSpy()
            let sut = RemoteAddAccount(url:url, httpClient: httpClientSpy)
            return (
                sut,
                httpClientSpy
            )
        }
        
       
    }
