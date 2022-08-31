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
    
    case capsules
    case launch
    
    public var method: HTTPMethod {
        switch self {
        case .capsules :
            return .get
        case .launch :
            return .post
        }
    }
    
    public var baseURL: String {
        return "https://api.spacexdata.com/"
    }
    
    public var path: String {
        switch self {
        case .capsules :
            return "v3/capsules"
        case .launch :
            return "v5/launches/query"
        }
    }
    
    
    public var parameters: Parameters? {
        switch self {
        case .capsules :
            return nil
        case .launch :
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let urlWithPathValue = baseURL + path
        guard let url = URL(string: urlWithPathValue) else { throw APIError.invalidURL }
        var urlRequest = URLRequest(url: url)
        switch self {
        case .capsules , .launch:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        }
        
        if let parameters = parameters {
            switch self {
                
            case .capsules  :
              return urlRequest
                
            case .launch :
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
                urlRequest.httpBody = jsonData
            }
        }
   
        return urlRequest
    }
    
    

}
