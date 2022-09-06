//
//  Home.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject private var vm : ViewModel = Resolver.shared.resolve(ViewModel.self)
    @ObservedObject var favorites : BookMarkID = Resolver.shared.resolve(BookMarkID.self)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.docsModel) { launch in
                    ZStack {
                        CellLaunch(name: launch.name ?? vm.defaultNameLaunch ,
                                   success: launch.success ?? false,
                                   details: launch.details ?? "" ,
                                   smallImageLink: "\(launch.links.patch.small)",
                                   flightNumber: "\(launch.flightNumber ?? 0)" ,
                                   launchTime: launch.dateUTC ?? "null" ,
                                   isBookMark: false,
                                   id: launch.id)
                        NavigationLink(destination: Details(name: launch.name ?? vm.defaultNameLaunch,
                                                            Description: launch.details ?? vm.defaultDetails,
                                                            urlLargeImage: "\(launch.links.patch.large)",
                                                            wikiLinkStr: launch.links.wikipedia ?? "null" ,
                                                            id: launch.id)) { EmptyView() }
                                                            .opacity(0.0)
                        
                    }

                } // ForEach
                if vm.launchListFull == false {
                    HStack {
                        Spacer()
                        ActivityIndicatorView(isAnimating: .constant(true), style: .large)
                        Spacer()
                    }
                    .onAppear {
                        vm.fetchDocs()
                    }
                }else {
                    HStack {
                        Spacer()
                        Text(vm.lasPageString)
                        Spacer()
                    }
                }
            }//List
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(vm.navigationBarString)
                        .font(.title)
                }
            }
        }//NavigationView
        .environmentObject(favorites)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

