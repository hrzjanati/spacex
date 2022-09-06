//
//  CellLaunch.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/3/22.
//

import SwiftUI


struct CellLaunch: View {
    
    @EnvironmentObject var favorites : BookMarkID
    
    var name : String
    var success : Bool
    var details : String
    var smallImageLink : String
    var flightNumber : String
    var launchTime : String
    var isBookMark : Bool
    var  id : String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                imageShip
                Spacer()
                HStack {
                    leftDetails
                    Spacer()
                    rightDetails
                    
                }//Hstack
                .padding(.horizontal)
                Spacer()
            }//Vstack
            .frame( height: 300, alignment: .center)
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
            if flightNumber == "0" {
                Text("flightNumber Null")
                    .font(.caption)
            }else {
                Text(flightNumber)
                    .font(.caption)
            }
            
            Text(details)
                .font(.caption)
                .foregroundColor(Color.gray)
            Spacer()
            
        }
    }//left details
    private var rightDetails : some View {
        VStack(alignment: .trailing) {
            Spacer()
            Text(launchTime)
            if success {
                Image(systemName: "checkmark.square.fill")
                    .foregroundColor(Color.green)
            }else {
                Image(systemName: "xmark.square.fill")
                    .foregroundColor(Color.red)
            }
       
                
            if self.favorites.contains(id) {
                Image(systemName: "bookmark.fill")
                    .accessibilityLabel(Text("this is a favorites id "))
                    .foregroundColor(.red)
            }else {
                Image(systemName: "bookmark")
            }
        }
    }// rightDetails
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



//struct CellLaunch_Previews: PreviewProvider {
//    let uuid = NSUUID()
//    static var previews: some View {
//        CellLaunch(name: "test name", success: true , details: "ast launch of the original Falcon 9 v1.0 launch vehicle", smallImageLink: "https://images2.imgbox.com/95/39/sRqN7rsv_o.png", flightNumber: "23", launchTime: "232434", id: UUID)
//            .previewLayout(.sizeThatFits)
//    }
//}
