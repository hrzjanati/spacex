//
//  HomeProvide.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/3/22.
//

import Foundation

protocol HomeProviding {
    var docs : [Doc] { get }
    var launchListFull : Bool { get }
    var navigationString : String { get }
    var strForLastPage : String { get }
    var defaultName : String { get }
    var defaultDetails : String { get }
    func fetchDataFromLaunchWebService(compilation : @escaping (([Doc],Bool) -> Void))
}

class HomeProvider: HomeProviding {
   
    private let cancelBag = CancelBag()
    private var currentPage = 0
    private var perPage : Int = 0
    private var fullPAge : Bool = false
    
    var docs: [Doc] {
        return [Doc]()
    }
    
    var launchListFull: Bool {
        get {
            return false
        }
       
    }
    
    var strForLastPage: String {
        return "The End. 😎"
    }
    
    var navigationString: String {
        return "Launch"
    }
    
    var defaultName: String {
        return "Name Is Null"
    }
    var defaultDetails: String {
        return "This mission has no description"
    }
    
    func fetchDataFromLaunchWebService(compilation : @escaping (([Doc],Bool) -> Void)) {
       
        APIRequestProvider().launch(pageNumber: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [self] result in
                switch result {
                case .success(let data):
                    print(data)
                    perPage = data.totalPages
                   
                    if currentPage < perPage {
                        compilation(data.docs,false)
                        currentPage += 1
                    }else {
                        compilation(data.docs,true)
                    }
                   
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
