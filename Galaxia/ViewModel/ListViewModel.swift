//
//  ListViewModel.swift
//  Galaxia
//
//  Created by Kiran on 27/09/23.
//

import UIKit

class ListViewModel: NSObject {

    public var successClosure: (() -> ())?
    public var failureClosure:(() -> ())?
    public var loadingStatus:(() -> ())?
    
    public var listResponse: ListResponse? {
        didSet{
            self.successClosure?()
        }
    }
    
    public var alertMessage: String? {
        didSet{
            self.failureClosure?()
        }
    }
    
    public var isLoading:Bool? {
        didSet{
            self.loadingStatus?()
        }
    }
}

extension ListViewModel{
    
    func callList() {
       self.isLoading = true

        GalaxiaServiceHelper.request(router: GalaxiaServiceManager.list) { [weak self] (result : Result<ListResponse, GalaxiaFetchError>) in
           
           guard let _self = self else { return }
           
           _self.isLoading = false
           
           switch result {
               
           case .success(let response): _self.listResponse = response
               
           case .failure(let errorMessage): _self.alertMessage = "\(errorMessage)"
               
           }
       }
   }
    
}
