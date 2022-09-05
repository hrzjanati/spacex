//
//  Details.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/5/22.
//

import SwiftUI

struct Details: View {
    
 
    var name : String
    var Description : String
    var urlLargeImage: String
    var wikiLinkStr : String
    
    
    var body: some View {
        ZStack {
            KFView(URLStr: urlLargeImage, width: .infinity, height: .infinity)
                .opacity(0.5)
                .blur(radius: 40)
                .listRowBackground(Color.clear)
            
            VStack {
                KFView(URLStr: urlLargeImage, width: 100, height: 100)
                
            }
                Form {
                    Section(header: Text("Aboute")) {
                        Text(name)
                    }
                    
                    Section(header: Text("Description")) {
                        Text(Description)
                    }
                    if wikiLinkStr != "null" {
                        Section(header: Text("Wiki")) {
                            Link(destination: URL(string: wikiLinkStr)!) {
                                Image(systemName: "link")
                                    .foregroundColor(Color.blue)
                            }
                            
                        }
                    }
                 
                }
         
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        Details(name: "Hossein", Description: "tetst", urlLargeImage: "https://images2.imgbox.com/60/48/jFYGyCf9_o.png", wikiLinkStr: "")
    }
}
