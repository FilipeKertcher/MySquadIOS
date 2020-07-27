//
//  InfraTests.swift
//  InfraTests
//
//  Created by Filipe Kertcher on 26/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import XCTest
import Infra
import Data
import Alamofire
 
class AlamoFireAdapterTests: XCTestCase {
    
    func test_post_should_make_with_valid_url_and_method() {
        let url = makeURL()
        
        testRequestFor(url: makeURL(), data: makeValidData() ) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
        
        
    }
    
    func test_post_should_make_with_no_data() {
        testRequestFor(data: nil ) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error() {
        
        expectResult(.failure(.noConnectivity), when : (data:nil,response:nil,error:makeError()  ) )
        
    }
    
    func test_post_should_complete_with_error_on_all_invalid_cases() {
        
        expectResult(.failure(.noConnectivity), when : (data:makeValidData(),response:makeHttpURLResponse(),error:makeError()  ) )
        expectResult(.failure(.noConnectivity), when : (data:makeValidData(),response:nil,error:makeError()  ) )
        expectResult(.failure(.noConnectivity), when : (data:makeValidData(),response:nil,error:nil  ) )
        expectResult(.failure(.noConnectivity), when : (data:nil,response:makeHttpURLResponse(),error:makeError()  ) )
        expectResult(.failure(.noConnectivity), when : (data:nil,response:makeHttpURLResponse(),error:nil ) )
        expectResult(.failure(.noConnectivity), when : (data:nil,response:nil,error:nil  ) )
        expectResult(.failure(.noConnectivity), when : (data:nil,response:makeHttpURLResponse(statusCode:300),error:nil  ) )

    }
    
    func test_post_should_complete_with_data_when_request_completes_with_200() {
        
        expectResult(.success(makeValidData()), when : (data:makeValidData(),response:makeHttpURLResponse(),error:nil  ) )
        
        
    }
    
    func test_post_should_complete_with_no_data_when_request_completes_with_204() {
           
           expectResult(.success(nil), when : (data:makeValidData(),response:makeHttpURLResponse(statusCode: 204),error:nil))
        
           expectResult(.success(nil), when : (data:makeEmptyData(),response:makeHttpURLResponse(statusCode: 204),error:nil))
        expectResult(.success(nil), when : (data:nil,response:makeHttpURLResponse(statusCode: 204),error:nil))
           
           
       }
    
    func test_post_should_complete_with_error_when_request_completes_with_http_error() {
        
        expectResult(.failure(.badRequest), when : (data:makeValidData(),response:makeHttpURLResponse(statusCode: 400),error:nil))
        expectResult(.failure(.serverError), when : (data:makeValidData(),response:makeHttpURLResponse(statusCode: 500),error:nil))
        expectResult(.failure(.unauthorized), when : (data:makeValidData(),response:makeHttpURLResponse(statusCode: 401),error:nil))
         expectResult(.failure(.forbidden), when : (data:makeValidData(),response:makeHttpURLResponse(statusCode: 403),error:nil))
        
    }
    
}

extension AlamoFireAdapterTests {
    func makeSut() -> AlamoFireAdapter {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration:config)
        
        return AlamoFireAdapter(session:session)
        
        
    }
    
    func testRequestFor(url:URL = makeURL(),data:Data?,action:@escaping (URLRequest) -> Void){
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        
        var request : URLRequest?
        
        sut.post(to: url,with: data){ _ in
            exp.fulfill()
        }
        
        URLProtocolStub.observe { request = $0 }
        
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectResult(_ expectedResult: Result<Data?,HttpError>, when stub: (data:Data?,response:HTTPURLResponse?,error:Error?),file:StaticString = #file,line:UInt = #line){
        let sut = makeSut()
        URLProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error )
        let exp = expectation(description: "waiting")
        
        
        sut.post(to: makeURL(), with: makeValidData()) {receivedResult in
            switch(expectedResult, receivedResult){
            case (.failure(let expectedError),.failure(let receivedError)): XCTAssertEqual(expectedError, receivedError,file:file,line:line)
            case (.success(let expectedResult),.success(let receivedResult)): XCTAssertEqual(expectedResult, receivedResult,file:file,line:line)
            default:XCTFail("Expect \(expectedResult) but got \(receivedResult)",file:file,line:line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    
}
