//
//  WebService.swift
//  SampleDeno
//
//  Created by Nurlan Akylbekov  on 08.11.2022.
//

import Foundation
import SystemConfiguration

public protocol WebService: AnyObject {
  func requestToNetwork(endpoint: Endpoint,
                        completion: @escaping (_ result: NetworkRequestResult) -> Void)
  
  func requestToNetwork<T: Codable>(for: T.Type, url: URL, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void)
  
  func requestToNetwork<T: Codable>(for: T.Type, url: URL, path: String, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void)
  
  func requestToNetwork<T: Codable>(for: T.Type, url: URL, path: String, method: HTTPMethod, body: JSON, completion: @escaping (Result<T, Error>) -> Void)
}

public final class WebServiceImpl: WebService {
  
  public init() {}
  
  public func requestToNetwork(endpoint: Endpoint, completion: @escaping (NetworkRequestResult) -> Void) {
    
    guard checkConnection() else {
      completion(.noInternet)
      return
    }
    
    do {
      let request = try request(route: endpoint)
      URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          completion(.error(error: error))
          return
        }
        
        guard let data = data else {
          return
        }
        
        completion(.success(data: data))
        
      }.resume()
    } catch {
      completion(.error(error: error))
    }
  }
  
  public func requestToNetwork<T>(for: T.Type, url: URL, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
    
  }

  public func requestToNetwork<T>(for: T.Type, url: URL, path: String, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
    
  }
  
  public func requestToNetwork<T>(for: T.Type, url: URL, path: String, method: HTTPMethod, body: JSON, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
    
  }
  
  private func request(route: Endpoint) throws -> URLRequest {
    return URLRequest(url: route.api.url,
                      cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                      timeoutInterval: 10.0)
  }
  
  public func parsePosts<T>(data: Data, completion: @escaping ([T]) -> Void) where T : Decodable, T : Encodable {
    
  }
  
  private func checkConnection() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        SCNetworkReachabilityCreateWithAddress(nil, $0)
      }
    }) else {
      return false
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
      return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
  }
}
