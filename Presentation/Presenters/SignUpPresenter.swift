//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Filipe Kertcher on 02/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation
import Domain

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator :EmailValidator
    private let addAccount: AddAccount
    public init(alertView:AlertView,emailValidator:EmailValidator,addAccount: AddAccount) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
    }
    
    public func signup(viewModel:SignupViewModel){
        if let (title, message) = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel:AlertViewModel(title:title,message:message))
        } else {
            let addAccountViewModel = AddAccountModel(name: viewModel.name!, email: viewModel.email!, socialMediaType: viewModel.socialMediaType!, token: viewModel.socialMediaToken!)
            
            addAccount.add(addAccountModel: addAccountViewModel) { result in
                switch result {
                case .failure: self.alertView.showMessage(viewModel:AlertViewModel(title:"Erro",message:"Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success : break;
                }
            }
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
        
        else if !emailValidator.isValid(email:viewModel.email!) {
            return (title:"Falha na validação",message:"Seu email não está no formato correto")
        }
        
        
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
