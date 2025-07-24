//
//  NetworkManager.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 21/07/2025.
//

import Foundation
import Combine

public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case serverError(error: String)
    case invalidJSON(_ error: String)
    case failedRequest
}

public typealias Headers = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol EndPoints {
    var baseURL: String { get }
    var path: String { get }
    var parameter: [URLQueryItem] { get }
    var headers: Headers { get }
    var method: HTTPMethod { get }
}

extension EndPoints {
    func getUrl() -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseURL
        component.path = path
        if !parameter.isEmpty {
            component.queryItems = parameter
        }
        return component.url
    }
}

public protocol Requestable {
    var requestTimeout: Float { get }
    func request<T: Codable>(_ requestModel: RequestModel) -> AnyPublisher<T, NetworkError>
}

public class NetworkRequestable: Requestable {
    
    let jsonDecoder = JSONDecoder()
    public var requestTimeout: Float = 30
    
    public func request<T>(_ requestModel: RequestModel) -> AnyPublisher<T, NetworkError> where T: Codable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(requestModel.requestTimeOut ?? requestTimeout)
        guard let request = requestModel.getUrlRequest() else {
            return Fail(outputType: T.self, failure: NetworkError.badURL("Bad URL")).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global())
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw NetworkError.serverError(error: "Server Error")
                }
                
                do {
                    return try self.jsonDecoder.decode(T.self, from: output.data)
                } catch {
                    throw NetworkError.invalidJSON("Json Error \(error.localizedDescription)")
                }
            }
            .mapError { error -> NetworkError in
                error as? NetworkError ?? .failedRequest
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


