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
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual( viewModel,self?.makeAlertViewModel(message:"O Campo nome é obrigatório"))
            
            exp.fulfill()
        }
        
        sut.signup(viewModel: makeSignupViewModel(name:nil))
        
        wait(for:[exp],timeout: 1)
        
        
    }
    
    func test_signup_show_error_mesasge_if_email_is_not_provided() {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        
        
        
        
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel,self?.makeAlertViewModel(message:"O Campo email é obrigatório"))
            exp.fulfill()
        }
        
        sut.signup(viewModel: makeSignupViewModel(email:nil))
        
        wait(for:[exp],timeout: 1)
    }
    
    func test_signup_show_error_mesasge_if_social_media_token_is_not_provided() {
        
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView:alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel,self?.makeAlertViewModel(title:"Falha na autenticação",message:"Não conseguimos nos autenticar com sua rede social"))
            exp.fulfill()
        }
        
        sut.signup(viewModel: makeSignupViewModel(socialMediaToken:nil))
        
        wait(for:[exp],timeout: 1)
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
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel,self?.makeAlertViewModel(message:"Seu email não está no formato correto"))
            exp.fulfill()
        }
        emailValidatorSpy.simulateInvalidEmail()
        sut.signup(viewModel: makeSignupViewModel())
        
        wait(for:[exp],timeout: 1)
    }
    
    
    func test_signup_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount:addAccountSpy)
        
        sut.signup(viewModel: makeSignupViewModel())
        
        XCTAssertEqual(addAccountSpy.addAccountModel,makeAddAccountModel())
    }
    
    
    func test_signup_should_show_error_message_if_add_account_fails() {
        
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView:alertViewSpy,addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel,self?.makeAlertViewModel(title:"Erro", message:"Algo inesperado aconteceu, tente novamente em alguns instantes."))
            
            exp.fulfill()
        }
        
        sut.signup(viewModel: makeSignupViewModel())
        addAccountSpy.completeWithError(error: .unexpected)
        wait(for:[exp],timeout: 1)
        
    }
    
    func test_signup_should_show_loading_before_and_after_call_add_account() {
        
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView:loadingViewSpy)
        
        let exp = expectation(description: "waiting")
        
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel,LoadingViewModel(isLoading: true))
            
            exp.fulfill()
        }
        sut.signup(viewModel: makeSignupViewModel())
        
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel,LoadingViewModel(isLoading: false))
            
            exp2.fulfill()
        }
        
        addAccountSpy.completeWithError(error: .unexpected)
        
        wait(for: [exp2], timeout: 1)
        
        
    }
    
    
}

extension SignUpPresenterTests {
    
    
    func makeSut(alertView:AlertViewSpy = AlertViewSpy(),emailValidator:EmailValidatorSpy = EmailValidatorSpy(),addAccount:AddAccountSpy = AddAccountSpy(),loadingView:LoadingView = LoadingViewSpy() ) -> SignUpPresenter {
        
        let sut = SignUpPresenter(alertView: alertView,emailValidator:emailValidator,addAccount:addAccount,loadingView:loadingView )
        
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
        var emit : ((AlertViewModel) -> Void)?
        
        func observe (completion: @escaping (AlertViewModel) -> Void){
            self.emit = completion
        }
        
        func showMessage(viewModel:AlertViewModel){
            self.emit?(viewModel)
        }
        
    }
    
    class LoadingViewSpy : LoadingView {
        
        var viewModel : LoadingViewModel?
        var emit : ((LoadingViewModel) -> Void)?
        
        func observe (completion: @escaping (LoadingViewModel) -> Void){
            self.emit = completion
        }
        
        func display(viewModel: LoadingViewModel) {
            self.emit?(viewModel)
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
        var completion : ((Result<AccountModel, DomainError>) -> Void)? = nil
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        
        func completeWithError(error:DomainError){
            completion?(.failure(error));
        }
        
        
    }
    
    
}
