//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Filipe Kertcher on 02/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import XCTest


struct SignupViewModel {
      var name: String?;
      var email : String?;
      var socialMediaType: String?;
      var socialMediaToken: String?;
}

class SignUpPresenter {
    
    private let alertView: AlertView
    
    init(alertView:AlertView) {
        self.alertView = alertView
    }
    
    func signup(viewModel:SignupViewModel){
        if viewModel.name == nil || viewModel.name!.isEmpty {
            alertView.showMessage(viewModel:AlertViewModel(title:"Falha na validação",message:"O Campo nome é obrigatório"))
        }
        
        if viewModel.email == nil || viewModel.email!.isEmpty {
            alertView.showMessage(viewModel:AlertViewModel(title:"Falha na validação",message:"O Campo email é obrigatório"))
        }
        
        if viewModel.socialMediaToken == nil || viewModel.socialMediaToken!.isEmpty {
            alertView.showMessage(viewModel:AlertViewModel(title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social"))
        }
        
        if viewModel.socialMediaType == nil || viewModel.socialMediaType!.isEmpty {
            alertView.showMessage(viewModel:AlertViewModel(title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social"))
        }
    }
    
    
}

protocol AlertView {
    func showMessage(viewModel:AlertViewModel)
}

struct AlertViewModel : Equatable {
    var title:String;
    var message:String
}

class SignupPresenterTests: XCTestCase {

    func test_signup_show_error_mesasge_if_name_is_not_provided() {
        
        
        let (sut,alertViewSpy) = makeSut()
        let signUpViewModel = SignupViewModel(email:"123",socialMediaType:"facebook",socialMediaToken:"123")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"O Campo nome é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_email_is_not_provided() {
        
        
        let (sut,alertViewSpy) = makeSut()
        let signUpViewModel = SignupViewModel(name:"Filipe Kertcher",socialMediaType:"facebook",socialMediaToken:"123")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"O Campo email é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_social_media_token_is_not_provided() {
        
        
        let (sut,alertViewSpy) = makeSut()
        let signUpViewModel = SignupViewModel(name:"Filipe Kertcher",email:"filipe@email.com", socialMediaType:"facebook")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social"))
    }

    func test_signup_show_error_mesasge_if_social_media_type_is_not_provided() {
        
        
        let (sut,alertViewSpy) = makeSut()
        let signUpViewModel = SignupViewModel(name:"Filipe Kertcher",email:"filipe@email.com", socialMediaToken: "123")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social"))
    }

}

extension SignupPresenterTests {
    
    
    func makeSut() -> (sut:SignUpPresenter, alertViewSpy: AlertViewSpy){
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy )
        
        return (
            sut,alertViewSpy
        )
    }
    class AlertViewSpy : AlertView {
        
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel:AlertViewModel){
            self.viewModel = viewModel
        }
        
        
        
        
    }
}
