//
//  File.swift
//  
//
//  Created by Noah Emmet on 1/24/20.
//

import Foundation

public enum QueryState<Data> {
  case idle
  case fetching
  case success(Data)
  case failure(Error)
  
  public var isIdle: Bool {
    if case .idle = self {
      return true
    } else {
      return false
    }
  }
  
  public var isFetching: Bool {
    if case .fetching = self {
      return true
    } else {
      return false
    }
  }
  
  public var data: Data? {
    if case .success(let data) = self {
      return data
    } else {
      return nil
    }
  }
  
  public var isSuccess: Bool {
    return data != nil
  }
  
  public var error: Error? {
    if case .failure(let error) = self {
      return error
    } else {
      return nil
    }
  }
  
  public var isError: Bool {
    return error != nil
  }
  
}
