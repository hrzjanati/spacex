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
                                success: launch.success ?? false,
                                details: launch.details ?? "" ,
                                smallImageLink: "\(launch.links.patch.small)")
                 } // ForEach
                 if vm.launchsListFull == false {
                   Text("fetching some data ...")
                     .onAppear {
                         vm.fetchDocs()
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


/*
struct Members: View {
    @ObservedObject var memberData = MemberData()
    
    var body: some View {
        NavigationView {
            List {
                // 1. Members
                ForEach(memberData.members) { member in
                    MembersListCell(member: member)
                }
                
                // 2. Activity Indicator. Last element of list.
                // Show activity spinner if backend has more data.
                // Its onAppear method is used to load new members. Pagination done.
                if memberData.membersListFull == false {
                    ActivityIndicator()
                    .onAppear {
                        memberData.fetchMembers()
                    }
                }
            }
            .navigationBarTitle("Members")
        }
    }
}
*/

