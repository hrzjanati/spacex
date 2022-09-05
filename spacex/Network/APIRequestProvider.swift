//
//  APIRequestProvider.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

public protocol APISpaceXClinetProtocol: AnyObject {
    func capsules() -> AnyPublisher<Result<Array<SpaceXCapsule>, AFError>, Never>
    func launch(pageNumber : Int) -> AnyPublisher<Result<SpaceXLaunch, AFError>, Never>
}

public final class APIRequestProvider {
    let jsonDecoder = JSONDecoder()
  
    public func performCombineRequest<T: Decodable>(route: APIRouter,interceptor: RequestInterceptor? = nil, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Result<T, AFError>, Never> {
        return AF.request(route).publishDecodable(type: T.self, decoder: decoder).result()
        
    }
}
//MARK: - APISpaceXClinetProtocol
extension APIRequestProvider : APISpaceXClinetProtocol {
  //MARK: - Capsules
    public func capsules() -> AnyPublisher<Result<Array<SpaceXCapsule>, AFError>, Never> {
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return performCombineRequest(route: .capsules, decoder: jsonDecoder)
    }
    //MARK: - Launch
    public func launch(pageNumber : Int) -> AnyPublisher<Result<SpaceXLaunch, AFError>, Never> {
        let parameters: [String: Any] = [
            "query" : ["upcoming" : false],
            "options" : [
                "limit" : 20 ,
                "page" : pageNumber,
                "sort": [
                    "flight_number": "desc"
         ]
                
            ]
        ]
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return performCombineRequest(route: .launch(parameters), decoder: jsonDecoder)
    }
}

