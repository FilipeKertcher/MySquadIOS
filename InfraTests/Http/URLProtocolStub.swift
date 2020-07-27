//
//  URLProtocolStub.swift
//  InfraTests
//
//  Created by Filipe Kertcher on 26/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

class URLProtocolStub : URLProtocol {
    
    static var error : Error?
    static var data : Data?
    static var response : HTTPURLResponse?
    
    static var emit : ((URLRequest) -> Void)?
    static func observe (completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit  = completion
    }
    
    static func simulate(data:Data?,response:HTTPURLResponse?,error:Error?){
        URLProtocolStub.data = data   
        URLProtocolStub.response = response
        URLProtocolStub.error = error
    }
    
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true;
    }
    
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    
    override open func startLoading() {
        URLProtocolStub.emit?(request)
        
        if let data = URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
        
    }
    
    override open func stopLoading() {
        
    }
    
}
