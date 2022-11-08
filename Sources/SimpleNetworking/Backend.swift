//
//  Backend.swift
//  
//
//  Created by Nurlan Akylbekov  on 08.11.2022.
//

import Foundation

public enum NetworkRequestResult {
  case success(data: Data)
  case error(error: Error)
  case noInternet
}
