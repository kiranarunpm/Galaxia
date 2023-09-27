//
//  ARBusinessServiceHelper.swift
//  Agri Reach
//
//  Created by Rafiudeen on 06/06/22.
//

import Foundation

class GalaxiaServiceHelper {
    
    class func request<T: Codable>(router: GalaxiaServiceManager, completion: @escaping (Result<T, GalaxiaFetchError>) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        // components.queryItems = router.parameters
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        print("URL===> ", url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        HTTPCookieStorage.shared.cookies?.forEach(HTTPCookieStorage.shared.deleteCookie) // for use deleteCookie
        
        for (key, value) in router.headerFields {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let data = router.body {
            urlRequest.httpBody = data
        }
        
        CommonServiceHelper.instance.request(forUrlRequest: urlRequest, completion: { (result : Result<Data, GalaxiaFetchError>) in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let data):
                    
                    do {
                        
                        if let dict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String : Any] {
                            
                            print("Response====> ", dict)
                            
                            if let responseObject = try? JSONDecoder().decode(T.self, from: data){
                                completion(.success(responseObject))
                                
                            }else {
                                completion(.failure(.inValidResponseFormat))
                            }
                            
                        }else {
                            
                            if let responseObject = try? JSONDecoder().decode(T.self, from: data){
                                completion(.success(responseObject))
                                
                            }else {
                                completion(.failure(.inValidResponseFormat))
                            }
                        }
                        
                    }catch (let error) {
                        completion(.failure(.message(error.localizedDescription)))
                    }
                    
                case .failure(let message):
                    print("hit failure - \(message)")
                    
                    completion(.failure(message))
                    
                }
            }
        })
    }

}
