//
//  HomeViewModel.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import Foundation
import Alamofire
import SwiftUI

extension Home {
    class ViewModel : ObservableObject {
        
        private var provider: HomeProviding = Resolver.shared.resolve(HomeProviding.self)
        @Published var docsModel : [Doc]
        @Published var launchListFull : Bool
    
        init() {
            self.docsModel = provider.docs
            self.launchListFull = provider.launchListFull
        }
    
        func fetchDocs() {
            provider.fetchDataFromLaunchWebService { doc , lastPage in
                self.launchListFull = lastPage
                if !lastPage {
                    withAnimation() {
                        self.docsModel.append(contentsOf: doc)
                    }
                }
            }
        }
    }
}
