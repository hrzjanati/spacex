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
    func launch() -> AnyPublisher<Result<SpaceXLaunch, AFError>, Never>
}

public final class APIRequestProvider {
    let jsonDecoder = JSONDecoder()
  
    public func performCombineRequest<T: Decodable>(route: APIRouter,interceptor: RequestInterceptor? = nil, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Result<T, AFError>, Never> {
        return AF.request(route).publishDecodable(type: T.self, decoder: decoder).result()
        
    }
}

extension APIRequestProvider : APISpaceXClinetProtocol {
  
    public func capsules() -> AnyPublisher<Result<Array<SpaceXCapsule>, AFError>, Never> {
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return performCombineRequest(route: .capsules, decoder: jsonDecoder)
    }
    
    public func launch() -> AnyPublisher<Result<SpaceXLaunch, AFError>, Never> {
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return performCombineRequest(route: .launch, decoder: jsonDecoder)
    }
 
}
