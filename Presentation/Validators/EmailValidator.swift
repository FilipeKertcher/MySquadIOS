//
//  EmailValidator.swift
//  Presentation
//
//  Created by Filipe Kertcher on 02/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation


public protocol EmailValidator {
    func isValid(email:String) -> Bool
}
