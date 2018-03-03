//
//  RestAPIClient.swift
//  MDB Socials
//
//  Created by Natasha Wong on 3/2/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

public enum ResourceNotFoundError: Error {
    case resourceNotFound
}

extension ResourceNotFoundError: LocalizedError {
    public var errorDescription: String? {
        return "The requested resource was not found in the database."
    }
}

public enum RequestTimedOutError: Error {
    case requestTimedOut
}

extension RequestTimedOutError: LocalizedError {
    public var errorDescription: String? {
        return "The network request timed out."
    }
}

class RestAPIClient {
    
    
    
}

