//
//  WebService.swift
//  SampleDeno
//
//  Created by Nurlan Akylbekov  on 08.11.2022.
//

import Foundation

public protocol WebService: AnyObject {
   func fetch()
}

public final class WebServiceImpl: WebService {
  
  public init() {}
  
  public func fetch() {
    let endpoint = Endpoint(api: .posts)
    
    print(endpoint.api.url)
  }
}
