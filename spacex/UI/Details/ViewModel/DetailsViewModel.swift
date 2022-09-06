//
//  DetailsViewModel.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/6/22.
//

import Foundation

extension Details {
    class ViewModel : ObservableObject {
        
        private var provider: DetailsProviding = Resolver.shared.resolve(DetailsProviding.self)
        
        @Published var headerAbout : String
        @Published var Description : String
        @Published var wikipedia   : String
        @Published var BookMark    :  String
        
        init() {
            self.headerAbout = provider.headerStr
            self.Description = provider.Description
            self.wikipedia   = provider.wikipedia
            self.BookMark    = provider.BookMark
            
        }
    }
}

