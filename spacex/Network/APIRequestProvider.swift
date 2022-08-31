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
    func fetchAll() -> AnyPublisher<Result<SpaceX, AFError>, Never>
}

public final class APIRequestProvider {

    public func performCombineRequest<T: Decodable>(route: APIRouter,interceptor: RequestInterceptor? = nil, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Result<T, AFError>, Never> {
        return AF.request(route ).publishDecodable(type: T.self, decoder: decoder).result()
        
    }
}

extension APIRequestProvider : APISpaceXClinetProtocol {
    
    public func fetchAll() -> AnyPublisher<Result<SpaceX, AFError>, Never> {
        let parameters: [String: Any] = ["" : ""]
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return performCombineRequest(route: .fetchAllData(parameters))
    }
    
    
}
