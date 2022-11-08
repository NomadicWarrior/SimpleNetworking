//
//  Endpoint.swift
//  
//
//  Created by Nurlan Akylbekov  on 08.11.2022.
//

import Foundation

typealias JSON = [String: Any]

protocol Requestable {
  var api: API { get }
}

public struct Endpoint: Requestable {
  
  public var api: API
  
  public init(api: API) {
    self.api = api
  }
}

public enum API {
  case posts
  
  func baseUrl() -> URL {
    return URL(string: "https://jsonplaceholder.typicode.com/")!
  }
  
  var path: String {
    switch self {
    case .posts:
      return "posts"
    }
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .posts:
      return .get
    }
  }
  
  var url: URL {
    switch self {
    case .posts:
      if #available(iOS 16.0, *) {
        return baseUrl().appending(component: self.path)
      } else {
        return baseUrl().appendingPathComponent(self.path)
      }
    }
  }
  
  var requestParameters: JSON? {
    switch self {
    case .posts:
      return nil
    }
  }
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}
