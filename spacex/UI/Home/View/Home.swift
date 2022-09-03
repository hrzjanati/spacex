//
//  Home.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject private var vm : ViewModel = Resolver.shared.resolve(ViewModel.self)
    
    var body: some View {
        NavigationView {
             List {
                 ForEach(vm.docsModel) { launch in
                     CellLaunch(name: launch.name ?? "Name is null" ,
                                success: launch.success ,
                                details: launch.details ?? "" ,
                                smallImageLink: "\(launch.links.patch.small)")
                 } // ForEach
             }//List
             .onAppear {
                 vm.fetchDocs()
             }// onAppear List
            
             .toolbar {
                 ToolbarItem(placement: .principal) {
                        Text("Launch")
                         .font(.title)
                 }
             }
        }//NavigationView
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
