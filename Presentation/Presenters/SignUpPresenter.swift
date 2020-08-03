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
    private let loadingView: LoadingView
    public init(alertView:AlertView,emailValidator:EmailValidator,addAccount: AddAccount,loadingView: LoadingView) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    
    public func signup(viewModel:SignUpViewModel){
        if let (title, message) = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel:AlertViewModel(title:title,message:message))
        } else {
            let addAccountViewModel = AddAccountModel(name: viewModel.name!, email: viewModel.email!, socialMediaType: viewModel.socialMediaType!, token: viewModel.socialMediaToken!)
            
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            addAccount.add(addAccountModel: addAccountViewModel) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .failure: self.alertView.showMessage(viewModel:AlertViewModel(title:"Erro",message:"Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success :self.alertView.showMessage(viewModel:AlertViewModel(title:"Sucesso!", message:"Conta criada com sucesso!"))
                }
                
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            }
        }
        
       
    }
    
    private func validate(viewModel: SignUpViewModel) -> (title:String,message:String)? {
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

