//
//  AF Adapter.swift
//  StrAlberry Part 1
//
//  Created by Alrzbod on 6/23/22.
//

import Foundation
import Alamofire


struct JWTTokenRequestAdapter: RequestAdapter {
    
    private let accessToken: String
    
    var authorizationHeader: [String: String] {
        return ["Authorization": "Bearer " + self.accessToken]
    }
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue("Bearer " + self.accessToken, forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }    
    //configure Alamofire Adapter
    
}
