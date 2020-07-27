//
//  Data.swift
//  Data
//
//  Created by Filipe Kertcher on 20/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation
//public extension Data {
//    func toModel<T:Decodable>() -> T? {
//        
//        return try? JSONDecoder().decode(T.self, from: self)
//    }
//}
//

public extension Data {
    func toModel<T:Decodable>() -> T? {
        
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func toJSON() -> [String:Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String:Any]
    }
}
