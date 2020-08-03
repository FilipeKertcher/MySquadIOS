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
       
        
        sut.signup(viewModel: makeSignupViewModel(name:nil))
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"O Campo nome é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_email_is_not_provided() {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        
       
        
        sut.signup(viewModel: makeSignupViewModel(email:nil))
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"O Campo email é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_social_media_token_is_not_provided() {
        
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        
        
        
        sut.signup(viewModel: makeSignupViewModel(socialMediaToken:nil))
        
        XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social"))
    }

    func test_signup_show_call_email_validator_with_correct_email() {
        
        let emailValidatorSpy = EmailValidatorSpy()
        
        let sut = makeSut(emailValidator:emailValidatorSpy)
        
        let signUpViewModel = makeSignupViewModel()
        
        sut.signup(viewModel: signUpViewModel)
        
        XCTAssertEqual(emailValidatorSpy.email,signUpViewModel.email)
    }
    
    func test_signup_should_show_error_message_if_invalid_email_is_provided() {
           
           let alertViewSpy = AlertViewSpy()
           let emailValidatorSpy = EmailValidatorSpy()
        
           let sut = makeSut(alertView:alertViewSpy, emailValidator:emailValidatorSpy)
           
           
           emailValidatorSpy.simulateInvalidEmail()
           sut.signup(viewModel: makeSignupViewModel())
            
           XCTAssertEqual(alertViewSpy.viewModel,AlertViewModel(title:"Falha na validação",message:"Seu email não está no formato correto"))
       }

}

extension SignUpPresenterTests {
    
    
    func makeSut(alertView:AlertViewSpy = AlertViewSpy(),emailValidator:EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {
        
        let sut = SignUpPresenter(alertView: alertView,emailValidator:emailValidator )
       
        return sut
    }
    
    func makeSignupViewModel(name:String? = "any name",email:String? = "email@etst.com",socialMediaToken:String? = "123", socialMediaType:String? = "facebook") -> SignupViewModel {
        
        return SignupViewModel(name:name,email:email,socialMediaToken:socialMediaToken,socialMediaType:socialMediaType)
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
        
        func simulateInvalidEmail () {
            isValid = false
        }
    }
}
