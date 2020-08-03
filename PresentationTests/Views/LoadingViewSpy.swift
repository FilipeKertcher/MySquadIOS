//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Filipe Kertcher on 03/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation
import Presentation

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

