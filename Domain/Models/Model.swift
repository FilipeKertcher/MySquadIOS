//
//  Model.swift
//  Domain
//
//  Created by Filipe Kertcher on 19/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

public protocol Model : Codable, Equatable{
    
}


public extension Model {
    func toData() -> Data? {
    return try? JSONEncoder().encode(self)
        
    }
}

