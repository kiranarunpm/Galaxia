//
//  ARServiceManager.swift
//  Agri Reach
//
//  Created by Rafiudeen on 19/05/22.
//

import Foundation

//// http://test.lascade.com/api/test/list
///
struct API {
    static var scheme = "http"
    static var baseURL = "test.lascade.com" //dev
    static var path = ""
    static var port = 0
}

enum HttpMethod: String {
    case get
    case post
    case put
    case PATCH
    case delete
}

enum ContentType : String {
    case formData = "multipart/form-data"
    case json = "application/json"
    case x_www_form_urlEncoded = "application/x-www-form-urlencoded"
    case Authorization = "Bearer "
    
}

enum GalaxiaServiceManager {
    
    case list

    var scheme: String {
        switch self {
        case .list: return API.scheme
        }
    }
    
    var host: String {
        switch self {
        case .list: return API.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .list: return "/api/test/list"
        }
    }
    
    var method: String {
        switch self {
        case .list: return HttpMethod.get.rawValue
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .list: return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .list: return nil
        }
    }
    
    
    var formDataParameters : [URLQueryItem]? {
        switch self {
        case .list : return nil
        }
    }
    
    var headerFields: [String : String] {
        let commonHeader : [String:String] = ["Content-Type" : ContentType.json.rawValue]
        switch self {
        case .list: return ["Content-Type" : ContentType.json.rawValue, "Accept":"*/*"]
        }
    }
}
