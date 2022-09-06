//
//  BookMark.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/6/22.
//

import SwiftUI

class BookMarkID : ObservableObject {
    
    private var resorts : Set<String>
    private var saveKey = "Favorites"
    
    init() {
        self.resorts = CoreDataManager.shared.fetchBookMarkID()
    }
    
    func contains( _ id : String) -> Bool {
        resorts.contains(id)
    }
    
    func add( _ id : String) {
        objectWillChange.send()
        resorts.insert(id)
        save()
    }
    
    func remove(_ id : String) {
        objectWillChange.send()
        resorts.remove(id)
        save()
    }
    
    func save() {
        CoreDataManager.shared.addIDInCoreData(id: resorts)
    }
    
    
}
