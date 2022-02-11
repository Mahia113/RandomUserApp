//
//  RandomUserModels.swift
//  RandomUserJusto
//
//

import Foundation

public struct ResponseRandomUser: Codable {
    public let results: [RandomUserModel]
}

public struct RandomUserModel: Codable {
    let gender: String
    let name: NameModel
    let location: LocationModel
    let email: String
    let login: LoginModel
    let dob: DobRegisteredModel
    let registered: DobRegisteredModel
    let phone: String
    let cell: String
    let id: IdModel
    let picture: PictureModel
    let nat: String
}

public struct NameModel: Codable {
    public let title: String
    public let first: String
    public let last: String
}

public struct LocationModel: Codable {
    public let street: StreetModel
    public let city: String
    public let state: String
    public let country: String
    public let postcode: PostCodeEnum
    public let coordinates: CoordinatesModel
    public let timezone: TimeZoneModel
}

public struct StreetModel: Codable {
    public let number: Int
    public let name: String
}

public struct CoordinatesModel: Codable {
    public let latitude: String
    public let longitude: String
}

public struct TimeZoneModel: Codable {
    public let offset: String
    public let description: String
}

public struct LoginModel: Codable {
    public let uuid: String
    public let username: String
    public let password: String
    public let salt: String
    public let md5: String
    public let sha1: String
    public let sha256: String
}

public struct DobRegisteredModel: Codable {
    public let date: String
    public let age: Int
}

public struct IdModel: Codable {
    public let name: String
    public let value: String?
}

public struct PictureModel: Codable {
    public let large: String
    public let medium: String
    public let thumbnail: String
}

public enum PostCodeEnum: Codable {
    
    case int(Int), string(String)
    
    public init(from decoder: Decoder) throws {
        
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        } else if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
    
        throw IdError.missingValue
    }
    
    enum IdError:Error { // If no case matched
        case missingValue
    }
    
    var any:Any{
        get{
            switch self {
            case .int(let value):
                return value
            case .string(let value):
                return value
            }
        }
    }
}
