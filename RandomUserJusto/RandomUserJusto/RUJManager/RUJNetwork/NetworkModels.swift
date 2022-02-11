//
//  NetworkModels.swift
//  RandomUserJusto
//
//

import Foundation

/**
 Types of network errors
 ### Properties
 - **invalidURL**: URL request error.
 - **invalidResponse**: HTTP request error.
 - **apiError**: API request error.
 - **decodingError**: Decoding request error.
 */
public enum NetworkHandlerError: Error {
    case invalidURL
    case invalidResponse(error: ErrorMessage)
    case apiError
    case decodingError
}

public struct ErrorMessage: Codable {
    let error: String
}
