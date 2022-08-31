//
//  HomeLaunch+Json.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 8/31/22.
//

import Foundation

import Foundation
import Alamofire

// MARK: - SpaceXLaunch
public struct SpaceXLaunch: Codable {
    let docs: [Doc]
    let totalDocs, offset, limit, totalPages: Int
    let page, pagingCounter: Int
    let hasPrevPage, hasNextPage: Bool
    let prevPage: JSONNull?
    let nextPage: Int
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDoc { response in
//     if let doc = response.result.value {
//       ...
//     }
//   }

// MARK: - Doc
struct Doc: Codable {
    let fairings: Fairings?
    let links: Links
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let net: Bool
    let window: Int
    let rocket: Rocket
    let success: Bool
    let failures: [Failure]
    let details: String?
    let crew: [JSONAny]
    let ships, capsules, payloads: [String]
    let launchpad: Launchpad
    let flightNumber: Int
    let name, dateUTC: String
    let dateUnix: Int
    let dateLocal: Date
    let datePrecision: DatePrecision
    let upcoming: Bool
    let cores: [Core]
    let autoUpdate, tbd: Bool
    let launchLibraryID: JSONNull?
    let id: String

    enum CodingKeys: String, CodingKey {
        case fairings, links
        case staticFireDateUTC
        case staticFireDateUnix
        case net, window, rocket, success, failures, details, crew, ships, capsules, payloads, launchpad
        case flightNumber
        case name
        case dateUTC
        case dateUnix
        case dateLocal
        case datePrecision
        case upcoming, cores
        case autoUpdate
        case tbd
        case launchLibraryID
        case id
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCore { response in
//     if let core = response.result.value {
//       ...
//     }
//   }

// MARK: - Core
struct Core: Codable {
    let core: String
    let flight: Int
    let gridfins, legs, reused, landingAttempt: Bool
    let landingSuccess, landingType, landpad: JSONNull?

    enum CodingKeys: String, CodingKey {
        case core, flight, gridfins, legs, reused
        case landingAttempt
        case landingSuccess
        case landingType
        case landpad
    }
}

enum DatePrecision: String, Codable {
    case hour = "hour"
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseFailure { response in
//     if let failure = response.result.value {
//       ...
//     }
//   }

// MARK: - Failure
struct Failure: Codable {
    let time: Int
    let altitude: Int?
    let reason: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseFairings { response in
//     if let fairings = response.result.value {
//       ...
//     }
//   }

// MARK: - Fairings
struct Fairings: Codable {
    let reused, recoveryAttempt, recovered: Bool?
    let ships: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt
        case recovered, ships
    }
}

enum Launchpad: String, Codable {
    case the5E9E4501F509094Ba4566F84 = "5e9e4501f509094ba4566f84"
    case the5E9E4502F5090995De566F86 = "5e9e4502f5090995de566f86"
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseLinks { response in
//     if let links = response.result.value {
//       ...
//     }
//   }

// MARK: - Links
struct Links: Codable {
    let patch: Patch
    let reddit: Reddit
    let flickr: Flickr
    let presskit: String?
    let webcast: String
    let youtubeID: String
    let article: String
    let wikipedia: String

    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, presskit, webcast
        case youtubeID
        case article, wikipedia
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseFlickr { response in
//     if let flickr = response.result.value {
//       ...
//     }
//   }

// MARK: - Flickr
struct Flickr: Codable {
    let small, original: [JSONAny]
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responsePatch { response in
//     if let patch = response.result.value {
//       ...
//     }
//   }

// MARK: - Patch
struct Patch: Codable {
    let small, large: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseReddit { response in
//     if let reddit = response.result.value {
//       ...
//     }
//   }

// MARK: - Reddit
struct Reddit: Codable {
    let campaign: JSONNull?
    let launch: String?
    let media, recovery: JSONNull?
}

enum Rocket: String, Codable {
    case the5E9D0D95Eda69955F709D1Eb = "5e9d0d95eda69955f709d1eb"
    case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

//extension DataRequest {
//    public func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
//        return DataResponseSerializer { _, response, data, error in
//            guard error == nil else { return .failure(error!) }
//
//            guard let data = data else {
//                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
//            }
//
//            return Result { try newJSONDecoder().decode(T.self, from: data) }
//        }
//    }
//
//    @discardableResult
//    public func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
//        return response(queue: queue!, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
//    }
//
//    @discardableResult
//    func responseSpaceXLaunch(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<SpaceXLaunch>) -> Void) -> Self {
//        return responseDecodable(queue: queue, completionHandler: completionHandler)
//    }
//}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
