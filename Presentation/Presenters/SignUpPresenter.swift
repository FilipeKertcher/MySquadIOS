//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Filipe Kertcher on 02/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator :EmailValidator
    
    public init(alertView:AlertView,emailValidator:EmailValidator) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    public func signup(viewModel:SignupViewModel){
        if let (title, message) = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel:AlertViewModel(title:title,message:message))
        }
        
       
    }
    
    private func validate(viewModel: SignupViewModel) -> (title:String,message:String)? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return (title:"Falha na validação",message:"O Campo nome é obrigatório")
         }
         
         else if viewModel.email  == nil || viewModel.email!.isEmpty {
             return (title:"Falha na validação",message:"O Campo email é obrigatório")
         }
         
         else if viewModel.socialMediaToken == nil || viewModel.socialMediaToken!.isEmpty {
            return (title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social")
         }
         
        else if viewModel.socialMediaType == nil || viewModel.socialMediaType!.isEmpty {
            return (title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social")
         }
        
        _ = emailValidator.isValid(email:viewModel.email!) 
        
        return nil
    }
    
    
}

public struct SignupViewModel {
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
