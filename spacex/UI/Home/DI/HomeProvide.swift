//
//  HomeProvide.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/3/22.
//

import Foundation


protocol HomeProviding {
    var docs : [Doc] { get  }
    func fetchDataFromGeneralWebService(complition : @escaping (([Doc]) -> Void))
}


class HomeProvider: HomeProviding {
    
    private let cancelBag = CancelBag()
    
    var docs: [Doc] {
            return [Doc]()
    }
    
     func fetchDataFromGeneralWebService(complition : @escaping (([Doc]) -> Void)) {
        APIRequestProvider().launchHossine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { result in
                switch result {
                case .success(let data):
                    print(data)
                    complition(data.docs)
                case .failure(let error):
#if DEBUG
                    print(error)
                    NSLog("\(error)")
#endif
                }
            }
            .store(in: cancelBag)
    }
}
