//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by Filipe Kertcher on 03/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

public struct SignUpViewModel {
      public var name: String?;
      public var email : String?;
      public var socialMediaType: String?;
      public var socialMediaToken: String?;
    
    public init(name:String? = nil,email:String? = nil ,socialMediaToken:String? = nil,socialMediaType:String? = nil) {
        self.name = name
        self.email = email
        self.socialMediaToken = socialMediaToken
        self.socialMediaType = socialMediaType
    }
}
