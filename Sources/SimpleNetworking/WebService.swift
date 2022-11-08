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
    print("1111-0 ", #function)
  }
}
