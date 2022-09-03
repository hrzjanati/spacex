//
//  CellLaunch.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/3/22.
//

import SwiftUI


struct CellLaunch: View {
    
    @State var name : String
    @State var success : Bool
    @State var details : String
    @State var smallImageLink : String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                imageShip
                Spacer()
                HStack {
                    leftDetails
                    Spacer()
                    righteDetails
                    
                }//Hstack
                .padding(.horizontal)
                Spacer()
            }//Vstack
            .frame( height: 250, alignment: .center)
            .cornerRadius(10.0)
            rockets
        }
    }
    
    
    private var imageShip : some View {
        ZStack {
            Image("spaceX")
                .resizable()
                .frame( height: 150, alignment: .center)
                .cornerRadius(5)
        }
    }//imageship
    
    private var leftDetails : some View {
        VStack (alignment: .leading){
            Text(name)
                .font(.title2)
            Text(details)
                .font(.caption)
                .foregroundColor(Color.gray)
            Spacer()
          
        }
    }//left details
    private var righteDetails : some View {
        VStack(alignment: .trailing) {
            Spacer()
            Text("lunch date")
            if success {
                Image(systemName: "checkmark.square.fill")
                    .foregroundColor(Color.green)
            }else {
                Image(systemName: "xmark.square.fill")
                    .foregroundColor(Color.red)
            }
        }
    }// righteDetails
    private var rockets : some View {
        HStack {
            Spacer()
            VStack (alignment: .leading){
                KFView(URLStr: smallImageLink, width: 60, height: 60)
                Spacer()
            }
        }
    }
}



struct CellLaunch_Previews: PreviewProvider {
    static var previews: some View {
        CellLaunch(name: "test name", success: true , details: "ast launch of the original Falcon 9 v1.0 launch vehicle", smallImageLink: "https://images2.imgbox.com/95/39/sRqN7rsv_o.png")
            .previewLayout(.sizeThatFits)
    }
}
