//
//  File.swift
//  
//
//  Created by Emrah Akgül on 23.01.2021.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public protocol Request {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get set }
    var headers: [String: String] { get }
    var body: Data? { get }
    var constructedURL: URL? {get}
}

extension Request {
    public var constructedURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = parameters
        return components.url
    }
}
