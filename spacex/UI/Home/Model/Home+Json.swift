//
//  Home+Json.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import Foundation

// MARK: - SpaceXCapsule
public struct SpaceXCapsule: Codable {
    let capsuleSerial: String
    let capsuleID: CapsuleID
    let status: Status
    let originalLaunch: String?
    let originalLaunchUnix: Int?
    let missions: [Mission]
    let landings: Int
    let type: TypeEnum
    let details: String?
    let reuseCount: Int

    public  enum CodingKeys: String, CodingKey {
        case capsuleSerial = "capsule_serial"
        case capsuleID = "capsule_id"
        case status
        case originalLaunch = "original_launch"
        case originalLaunchUnix = "original_launch_unix"
        case missions, landings, type, details
        case reuseCount = "reuse_count"
    }
}

public enum CapsuleID: String, Codable {
    case dragon1 = "dragon1"
    case dragon2 = "dragon2"
}

// MARK: - Mission
public struct Mission: Codable {
    let name: String
    let flight: Int
}

public enum Status: String, Codable {
    case active = "active"
    case destroyed = "destroyed"
    case retired = "retired"
    case unknown = "unknown"
}

public enum TypeEnum: String, Codable {
    case dragon10 = "Dragon 1.0"
    case dragon11 = "Dragon 1.1"
    case dragon20 = "Dragon 2.0"
}

typealias SpaceXCapsules = [SpaceXCapsule]
