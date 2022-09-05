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
                     NavigationLink(destination: Details(name: launch.name ?? "Name is null", Description: launch.details ?? "This mission no Description", urlLargeImage: "\(launch.links.patch.large)", wikiLinkStr: launch.links.wikipedia ?? "null")) {
                         CellLaunch(name: launch.name ?? "Name is null" ,
                                    success: launch.success ?? false,
                                    details: launch.details ?? "" ,
                                    smallImageLink: "\(launch.links.patch.small)",
                                    flightNumber: "\(launch.flightNumber ?? 0)" ,
                                    launchTime: launch.dateUTC ?? "null",
                                    id: launch.id)
                     }
                     .buttonStyle(PlainButtonStyle())
                 } // ForEach
                 if vm.launchListFull == false {
                     HStack {
                         Spacer()
                         ActivityIndicatorView(isAnimating: .constant(true), style: .large)
                         Spacer()
                     }
                     .onAppear {
                         vm.fetchDocs()
                         let ids = CoreDataManager.shared.fetchBookMarkID()
                         print(ids)
                     }
                 }
             }//List
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

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
