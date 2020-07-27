//
//  TestFactories.swift
//  DataTests
//
//  Created by Filipe Kertcher on 26/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

func makeURL() -> URL {
    return URL(string:"http://localhost:3000")!
}

func makeInvalidData() -> Data {
    return Data("invalid data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\": \"Filipe\" }".utf8)
}

func makeError () -> NSError {
    return NSError(domain:"any_error",code:0)
}

func makeHttpURLResponse (statusCode:Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func makeEmptyData (statusCode:Int = 200) -> Data {
    return Data()
}
