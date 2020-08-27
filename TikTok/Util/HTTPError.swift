//
//  HTTPError.swift
//  TikTok
//
//  Created by Ganesh Bisht on 10/08/20.
//  Copyright © 2020 TikTok. All rights reserved.
//


import Foundation

enum HTTPError: Error {
    case failureParsingHTTPResponse
}

extension HTTPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failureParsingHTTPResponse:
            return "Error parsing HTTPResponse."
        }
    }
}
