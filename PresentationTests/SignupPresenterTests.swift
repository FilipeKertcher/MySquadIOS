//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Filipe Kertcher on 02/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import XCTest
import Presentation



class SignUpPresenterTests: XCTestCase {

    func test_signup_show_error_mesasge_if_name_is_not_provided() {
        
        
        let (sut,alertViewSpy) = makeSut()
        let signUpViewModel = SignupViewModel(email:"facebook",socialMediaToken:"123",socialMediaType: "facebook")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"O Campo nome é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_email_is_not_provided() {
        
        
        let (sut,alertViewSpy) = makeSut()
        let signUpViewModel = SignupViewModel(name:"Filipe Kertcher",socialMediaToken:"123", socialMediaType:"facebook")
        
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

extension SignUpPresenterTests {
    
    
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
