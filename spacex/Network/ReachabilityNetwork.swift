//
//  ReachabilityNetwork.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import Network
import SwiftUI

enum NetworkStatus: String {
   case connected
   case disconnected
}

class Monitor: ObservableObject {
  
    private let monitor = NWPathMonitor()
   private let queue = DispatchQueue(label: "Monitor")

   @Published var status: NetworkStatus = .connected
    var disconnectedNet = false

   init() {
       monitor.pathUpdateHandler = { [weak self] path in
           guard let self = self else { return }

           // Monitor runs on a background thread so we need to publish
           // on the main thread
           DispatchQueue.main.async {
               if path.status == .satisfied {
                   print("We're connected!")
                   self.status = .connected
               } else {
                   print("No connection.")
                   self.status = .disconnected
                   self.disconnectedNet = true
               }
           }
       }
       monitor.start(queue: queue)
   }
}
