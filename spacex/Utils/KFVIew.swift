//
//  KFVIew.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/3/22.
//

import Foundation
import SwiftUI
import Kingfisher

struct KFView: View {
   
    var URLStr: String
    let width: CGFloat
    let height : CGFloat
 
    var body: some View {
        KFImage.url(URL(string: URLStr))
            .fade(duration: 1)
            .resizable()
            .frame(maxWidth: width , maxHeight: height)
            .background (
                KFImage.url(URL(string: URLStr))
                    .resizable()
                    .frame(maxWidth: .infinity , maxHeight: .infinity)
                    .blur(radius: 60)
                    .opacity(0.75)
            )
    }
    private var scale: CGFloat {
           UIScreen.main.scale
       }
}

struct ImageRows_Previews: PreviewProvider {
    static var previews: some View {
        let strUrl = "http://185.255.88.17:8095/static/characters/1/avatar.png"
        KFView(URLStr: strUrl, width: .infinity , height: .infinity)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
