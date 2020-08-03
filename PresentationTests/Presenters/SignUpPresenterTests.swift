//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Filipe Kertcher on 02/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import XCTest
import Presentation
import Domain


class SignUpPresenterTests: XCTestCase {

    func test_signup_show_error_mesasge_if_name_is_not_provided() {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
       
        
        sut.signup(viewModel: makeSignupViewModel(name:nil))
        
        XCTAssertEqual(alertViewSpy.viewModel,makeAlertViewModel(message:"O Campo nome é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_email_is_not_provided() {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        
       
        
        sut.signup(viewModel: makeSignupViewModel(email:nil))
        
        XCTAssertEqual(alertViewSpy.viewModel,makeAlertViewModel(message:"O Campo email é obrigatório"))
    }
    
    func test_signup_show_error_mesasge_if_social_media_token_is_not_provided() {
        
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        
        
        
        sut.signup(viewModel: makeSignupViewModel(socialMediaToken:nil))
        
        XCTAssertEqual(alertViewSpy.viewModel,makeAlertViewModel(title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social"))
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
            
           XCTAssertEqual(alertViewSpy.viewModel,makeAlertViewModel(message:"Seu email não está no formato correto"))
       }
    
    
    func test_signup_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        
        let sut = makeSut(addAccount:addAccountSpy)
        
        sut.signup(viewModel: makeSignupViewModel())
         
        XCTAssertEqual(addAccountSpy.addAccountModel,makeAddAccountModel())
    }

}

extension SignUpPresenterTests {
    
    
    func makeSut(alertView:AlertViewSpy = AlertViewSpy(),emailValidator:EmailValidatorSpy = EmailValidatorSpy(),addAccount:AddAccountSpy = AddAccountSpy()) -> SignUpPresenter {
        
        let sut = SignUpPresenter(alertView: alertView,emailValidator:emailValidator,addAccount:addAccount )
       
        return sut
    }
    
    func makeSignupViewModel(name:String? = "Filipe Kertcher",email:String? = "filipekertcher97@gmail.com",socialMediaToken:String? = "123456", socialMediaType:String? = "FACEBOOK") -> SignupViewModel {
        
        return SignupViewModel(name:name,email:email,socialMediaToken:socialMediaToken,socialMediaType:socialMediaType)
    }
    
    func makeAlertViewModel(title:String = "Falha na validação", message: String) -> AlertViewModel{
        return AlertViewModel(title:title,message:message)
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
    
    class AddAccountSpy : AddAccount {
        var addAccountModel : AddAccountModel?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
        }
        
       
        
         
    }
}
