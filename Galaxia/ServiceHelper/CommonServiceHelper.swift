//
//  CommonServiceHelper.swift
//  Agri Reach
//
//  Created by Rafiudeen on 19/05/22.
//

import UIKit

enum StatusCode: Int {
    case success = 200
    case unAuthorized = 401
    case internalServerError = 500
    case badRequest = 400
    case payLoadError = 413
    case created = 201

}

enum GalaxiaFetchError: Error {
    case invalidURL
    case missingData
    case message(String)
    case inValidResponseFormat
    case offline(String)
    case unKnown
    case LoggedOut
}

struct RefreshTokenRequest: Codable{
    let refreshToken: String?
}

//MARK: TEMP SAVE URLREQUEST
var tokenExpiredReq: URLRequest?


class CommonServiceHelper: NSObject {
    
    static let instance = CommonServiceHelper()
    
    public func request(forUrlRequest urlRequest: URLRequest, completion: @escaping (Result<Data, GalaxiaFetchError>) -> ()) {

      
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            print("response", response as Any)
            self.processResponse(urlRequest: urlRequest, data: data, response: response, error: error, completion: completion)
        }
        dataTask.resume()
        
    }
    
    private func processResponse(urlRequest: URLRequest, data: Data?, response: URLResponse?, error: Error?, completion : @escaping (Result<Data, GalaxiaFetchError>) -> ()) {
        
        guard error == nil else {
            
            if let errorDesc = error?.localizedDescription {
                completion(.failure(.message("HTTP Request Failed \(errorDesc)")))
            }
            return
        }
        
        guard response != nil else {
            completion(.failure(.inValidResponseFormat))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, let statusCode = StatusCode(rawValue: httpResponse.statusCode) else {
            completion(.failure(.inValidResponseFormat))
            return
        }
        
        switch statusCode {
            
        case .success:
            
            guard let _data = data else {
                completion(.failure(.missingData))
                return
            }
            completion(.success(_data))
            
        case .created:
            
            guard let _data = data else {
                completion(.failure(.missingData))
                return
            }
            completion(.success(_data))

        case .unAuthorized:
            guard let _data = data else {
                completion(.failure(.inValidResponseFormat))
                return
            }
        case .internalServerError:
            completion(.failure(.message("InternalServerError")))
        case .badRequest:
            
            guard let _data = data else {
                completion(.failure(.missingData))
                return
            }
            
            do {
                
                if let dict = try JSONSerialization.jsonObject(with: _data, options: [.allowFragments]) as? [String : Any] {
                    print("Response ==>", dict)
                    
                    if let messageDict = dict["message"] as? [String : Any],  let errorMessage = messageDict["Details"] as? String {
                        completion(.failure(.message(errorMessage)))
                        return
                    }
                    
                    if let errorMessage = dict["message"] as? String {
                        completion(.failure(.message(errorMessage)))
                        return
                    }
                    
                    if let messageDict = dict["message"] as? [String : Any],  let errorMessage = messageDict["message"] as? String {
                        completion(.failure(.message(errorMessage)))
                        return
                    }
                    
                    if let messageDict = dict["message"] as? [String] {
                        completion(.failure(.message(messageDict.joined(separator: ", "))))
                        return
                    }
                    
                    if let messageDict = dict["message"] as? [AnyObject],  let errorMessage = messageDict[0]["Details"] as? String {
                        completion(.failure(.message(errorMessage.description)))
                        return
                    }
                    
                    completion(.failure(.message("Property required should not exist")))
                    return
                    
                }
                
            }catch (let error) {
                completion(.failure(.message(error.localizedDescription)))
            }
            
        case .payLoadError:
            
            completion(.failure(.message("Request entity too large")))
            return
        }
    }
    
}
