//
//  APIRouter.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import Foundation
import Alamofire
import SwiftUI

public enum APIRouter: APIConfiguration {
    
    case fetchAllData(_ parameters: [String: Any])
    
    
    public var method: HTTPMethod {
        switch self {
        case .fetchAllData :
            return .post
        }
    }
    
    public var baseURL: String {
        return "https://api.spacexdata.com/v5/launches/query"
    }
    
    public var path: String {
        switch self {
        case .fetchAllData :
            return ""
        }
    }
    
    
    public var parameters: Parameters? {
        switch self {
        case .fetchAllData(let parameters) :
            return parameters
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let urlWithPathValue = baseURL + path
        guard let url = URL(string: urlWithPathValue) else { throw APIError.invalidURL }
        var urlRequest = URLRequest(url: url)
        
        switch self {
            
        case .fetchAllData(_) :
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters as Any)
            urlRequest.httpBody = jsonData
        }
        
        
        return urlRequest
    }
    
    

}
