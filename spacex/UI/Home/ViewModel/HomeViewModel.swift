//
//  HomeViewModel.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import Foundation


extension Home {
    class ViewModel : ObservableObject {
        
        private let cancelBag = CancelBag()
        
        init() {
            fetchDataFromGeneralWebService()
        }
        
        func fetchDataFromGeneralWebService() {
            APIRequestProvider().launch()
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    print("error")
                } receiveValue: { result in
                    switch result {
                    case .success(let data):
                        print(data)
                    case .failure(let error):
#if DEBUG
                        print(error)
#endif
                    }
                }
                .store(in: cancelBag)
            
        }
        
    }
}
