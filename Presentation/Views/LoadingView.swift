//
//  AlertView.swift
//  Presentation
//
//  Created by Filipe Kertcher on 02/08/20.
//  Copyright © 2020 Filipe Kertcher. All rights reserved.
//

import Foundation

public protocol LoadingView {
     func display(viewModel:LoadingViewModel)
}

public struct LoadingViewModel : Equatable {
    public var isLoading: Bool?
    
    public init(isLoading:Bool){
        self.isLoading = isLoading
        
    }
}
