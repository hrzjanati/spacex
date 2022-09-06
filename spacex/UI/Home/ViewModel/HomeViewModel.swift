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
        @Published var navigationBarString : String
        @Published var lasPageString : String
        @Published var defaultNameLaunch : String
        @Published var defaultDetails : String
        
        init() {
            self.docsModel = provider.docs
            self.launchListFull = provider.launchListFull
            self.navigationBarString = provider.navigationString
            self.lasPageString = provider.strForLastPage
            self.defaultNameLaunch = provider.defaultName
            self.defaultDetails = provider.defaultDetails
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
