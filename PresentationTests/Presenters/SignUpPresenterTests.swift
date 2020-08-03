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
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        let signUpViewModel = SignupViewModel(email:"facebook",socialMediaToken:"123",socialMediaType: "facebook")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"O Campo nome é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_email_is_not_provided() {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        
        let signUpViewModel = SignupViewModel(name:"Filipe Kertcher",socialMediaToken:"123", socialMediaType:"facebook")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"O Campo email é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_social_media_token_is_not_provided() {
        
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        
        let signUpViewModel = SignupViewModel(name:"Filipe Kertcher",email:"filipe@email.com", socialMediaType:"facebook")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social"))
    }

    func test_signup_show_call_email_validator_with_correct_email() {
        
        let emailValidatorSpy = EmailValidatorSpy()
        
        let sut = makeSut(emailValidator:emailValidatorSpy)
        
        let signUpViewModel = SignupViewModel(name:"Filipe Kertcher",email:"filipe@email.com", socialMediaToken: "123",socialMediaType:"facebook")
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(emailValidatorSpy.email,signUpViewModel.email)
    }
    
    func test_signup_should_show_error_message_if_invalid_email_is_provided() {
           
           let alertViewSpy = AlertViewSpy()
           let emailValidatorSpy = EmailValidatorSpy()
        
           let sut = makeSut(alertView:alertViewSpy, emailValidator:emailValidatorSpy)
           let signUpViewModel = SignupViewModel(name:"Filipe Kertcher",email:"filipe@email.com", socialMediaToken: "123",socialMediaType:"facebook")
           
           emailValidatorSpy.isValid = false
           sut.signup(viewModel: signUpViewModel)
           
           XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"Seu email não está no formato correto"))
       }

}

extension SignUpPresenterTests {
    
    
    func makeSut(alertView:AlertViewSpy = AlertViewSpy(),emailValidator:EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {
        
        let sut = SignUpPresenter(alertView: alertView,emailValidator:emailValidator )
       
        return sut
    }
    
     
    class AlertViewSpy : AlertView {
        
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel:AlertViewModel){
            self.viewModel = viewModel
        }
        
    }
    
    class EmailValidatorSpy : EmailValidator {
        var isValid = true
        var email : String?
        
        func isValid(email:String) -> Bool {
            self.email = email
            return isValid
        }
    }
}
