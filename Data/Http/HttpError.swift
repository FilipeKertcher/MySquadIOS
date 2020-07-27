//
//  HttpError.swift
//  Data
//
//  Created by Filipe Kertcher on 19/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

public enum HttpError :Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
