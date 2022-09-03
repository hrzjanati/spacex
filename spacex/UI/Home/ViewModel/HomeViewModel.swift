//
//  HomeViewModel.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import Foundation
import Alamofire

extension Home {
    class ViewModel : ObservableObject {
        
        private var provider: HomeProviding = Resolver.shared.resolve(HomeProviding.self)
        @Published var docsModel : [Doc]
        
        init() {
            self.docsModel = provider.docs
            
        }
    
        func fetchDocs() {
            provider.fetchDataFromGeneralWebService { doc in
                self.docsModel = doc
            }
        }
        
    }
}

