//
//  HttpClient.swift
//  Data
//
//  Created by Filipe Kertcher on 19/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

public protocol HttpPostClient {
    func post(to url:URL,with data: Data?,completion:@escaping (Result<Data?,HttpError>) -> Void)
} 

 
