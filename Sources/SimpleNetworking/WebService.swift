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
}

public final class WebServiceImpl: WebService {
  
  private let networkReachabilityManager = SCNetworkReachabilityFlags()
  
  public init() {}
  
  public func requestToNetwork(endpoint: Endpoint, completion: @escaping (NetworkRequestResult) -> Void) {
    
    guard networkReachabilityManager.contains(.reachable) else {
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
  
  private func request(route: Endpoint) throws -> URLRequest {
    return URLRequest(url: route.api.url,
                      cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                      timeoutInterval: 10.0)
  }
}
