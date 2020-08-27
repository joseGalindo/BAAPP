//
//  ApiService.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 25/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import Foundation
import Alamofire

final class ApiService {
    
    private let baseURL = URL(string: Constants.API_BASE)!
    private var decoder : JSONDecoder!
    public typealias APIRequestCompletionHandler<T : Decodable> = (Result<T, APIError>) -> Void
    
    public enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }
    
    public enum Endpoint {
        case tvShows
        case detailShow(identifier: Int)
        func path() -> String {
            switch self {
            case .tvShows:
                return "shows"
            case let .detailShow(identifier):
                return "shows/\(identifier)"
            }
        }
    }
    
    static let shared : ApiService = ApiService()
    private init() {
        decoder = JSONDecoder()
    }
    
    public func GET<T: Decodable>(endpoint : Endpoint,
                                  params: [String: String]?,
                                  completionHandler : @escaping APIRequestCompletionHandler<T>) {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        AF.request(queryURL.absoluteString, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .response { (response) in
            switch response.result {
            case .success(let dataResponse):
                guard let data = dataResponse else {
                    completionHandler(.failure(.noResponse))
                    return
                }
                do {
                    let object = try self.decoder.decode(T.self, from: data)
                    completionHandler(.success(object))
                } catch let errorD {
                    DispatchQueue.main.async {
                        #if DEBUG
                        print("JSON Decoding Error: \(errorD)")
                        #endif
                        completionHandler(.failure(.jsonDecodingError(error: errorD)))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(.networkError(error: error)))
            }
        }
    }
    
    public func getShows(completionHandler : @escaping APIRequestCompletionHandler<[Show]>) {
        let queryURL = baseURL.appendingPathComponent(Endpoint.tvShows.path())
        AF.request(queryURL.absoluteString, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Show].self) { (response) in
                switch response.result {
                case .success(let shows):
                    completionHandler(.success(shows))
                case .failure(let error):
                    completionHandler(.failure(.networkError(error: error)))
                }
        }
        
    }
    
}
