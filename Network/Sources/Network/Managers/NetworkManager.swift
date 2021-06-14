//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

final class NetworkManager {
    enum Error: Swift.Error {
        enum Data: Swift.Error {
            case missing
            case read(underlying: DecodingError)
        }
        case corruptedURL
        case connection(reason: Swift.Error)
        case http(code: Int)
        case data(reason: Data)
        case other
    }
    
    static let `default`: NetworkManager = NetworkManager()
    
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private func createRequest<R: Request>(request: R) -> URLRequest? {
        guard let requestURL = request.constructedURL else {
            return nil
        }
        
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        return urlRequest
    }
    
    public func makeRequest<R: Request, S: Decodable>(request: R, completionHandler: @escaping (S?, Error?) -> Void){
        DispatchQueue.main.async {
            guard let urlRequest = self.createRequest(request: request) else {
                completionHandler(nil, .corruptedURL)
                return
            }

            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else {
                    #if DEBUG
                    print("No Response!")
                    #endif
                    completionHandler(nil, .other)
                    return
                }
                if let error = error {
                    #if DEBUG
                    print("Connection Error: " + error.localizedDescription)
                    #endif

                    completionHandler(nil, .connection(reason: error))

                    return
                }
                if response.statusCode < 200 || response.statusCode >= 400 {
                    #if DEBUG
                    print("HTTP Error: " + String(describing: response.statusCode))
                    #endif
                    completionHandler(nil, .http(code: response.statusCode))
                }
                else {
                    guard let data = data else {
                        #if DEBUG
                        print("No Data!")
                        #endif
                        completionHandler(nil, .data(reason: .missing))
                        return
                    }
                    do {
                        let response = try NetworkManager.decoder.decode(S.self, from: data)
                        completionHandler(response, nil)
                    } catch let error as DecodingError {
                        completionHandler(nil, .data(reason: .read(underlying: error)))
                    } catch {
                        completionHandler(nil, .other)
                    }
                }
            }
            task.resume()
        }
    }

}
