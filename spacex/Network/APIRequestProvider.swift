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
    let retryLimit = 5
    public func performCombineRequest<T: Decodable>(route: APIRouter,interceptor: RequestInterceptor? = nil, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Result<T, AFError>, Never> {
        return AF.request(route, interceptor: interceptor ?? self).publishDecodable(type: T.self, decoder: decoder).result()
        
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
//MARK: - Interceptor
extension APIRequestProvider : RequestInterceptor {
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error,
                      completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
#if DEBUG
        print("retry statusCode....\(statusCode)")
#endif
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
        case 429:
            completion(.retry)
        default:
            completion(.retry)
        }
    }
}
