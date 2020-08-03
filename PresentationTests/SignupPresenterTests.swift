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
