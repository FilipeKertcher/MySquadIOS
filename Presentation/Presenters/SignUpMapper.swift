//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Filipe Kertcher on 03/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation
import Domain

public final class SignUpMapper {
    static func toAddAccountModel(viewModel:SignUpViewModel) -> AddAccountModel {
        return AddAccountModel(name: viewModel.name!, email: viewModel.email!, socialMediaType: viewModel.socialMediaType!, token: viewModel.socialMediaToken!)
        
        
    }
}
