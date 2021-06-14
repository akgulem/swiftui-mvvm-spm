//
//  File.swift
//  
//
//  Created by Emrah Akgül on 23.01.2021.
//

import Foundation

public protocol GetRequest: Request {
    
}

public extension GetRequest {
    var method: HTTPMethod {
        return .GET
    }
    
    var body: Data?  {
        return nil
    }
}
