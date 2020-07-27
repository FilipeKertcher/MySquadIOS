//
//  Spy.swift
//  DataTests
//
//  Created by Filipe Kertcher on 26/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation
import Data 
class HttpClientSpy : HttpPostClient {
           
           var url : URL?;
           var data : Data?
           var completion: ((Result<Data?,HttpError>) -> Void)?
           
           func post(to url:URL,with data:Data?,completion:@escaping (Result<Data?,HttpError>) -> Void) {
               self.url = url
               self.data = data
               self.completion = completion
           }
           
           func completeWithError(_ error:HttpError) {
               completion?(.failure(error))
           }
           
           func completeWithData(_ data:Data) {
               completion?(.success(data))
           }
           
           
           init() {
               
           }
       }
