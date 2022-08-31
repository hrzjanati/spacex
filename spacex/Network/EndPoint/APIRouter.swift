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
    
    
    public var method: HTTPMethod {
        switch self {
        case .capsules :
            return .get
        }
    }
    
    public var baseURL: String {
        return "https://api.spacexdata.com/v3/"
    }
    
    public var path: String {
        switch self {
        case .capsules :
            return "capsules"
        }
    }
    
    
    public var parameters: Parameters? {
        switch self {
        case .capsules :
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let urlWithPathValue = baseURL + path
        guard let url = URL(string: urlWithPathValue) else { throw APIError.invalidURL }
        var urlRequest = URLRequest(url: url)
        
        switch self {
            
        case .capsules :
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
        }
        
        
        return urlRequest
    }
    
    

}
