//
//  DetailsProvide.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/6/22.
//

import Foundation

protocol DetailsProviding {
    var headerStr : String { get }
    var Description : String { get }
    var wikipedia : String { get }
    var BookMark : String { get }
    
}

class DetailsProvider : DetailsProviding {
    
    var headerStr: String {
        return "About"
    }
    
    var Description: String {
        return "Description"
    }
    
    var wikipedia: String{
        return "wikipedia"
    }
    
    var BookMark: String{
        return "BookMark"
    }
    
}
