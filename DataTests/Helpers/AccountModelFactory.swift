//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Filipe Kertcher on 26/07/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation
import Domain

func makeAccountModel()  -> AccountModel {
    return AccountModel(_id:"any id",name: "Filipe Kertcher", email: "filipekertcher97@gmail.com", socialMediaType: "FACEBOOK", token: "123456")
}

