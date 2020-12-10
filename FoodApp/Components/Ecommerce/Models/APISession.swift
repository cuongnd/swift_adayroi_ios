//
//  APISession.swift
//  FoodApp
//
//  Created by MAC OSX on 12/9/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class APISession {
    public static var shared = APISession()
    
    typealias response = Single<Data>
    
    func callApi(url:String,method:String) -> response {
        let method1=method.lowercased()
        var httpMethod:HTTPMethod = .post
        if(method1=="get"){
            httpMethod = .get
        }
        return Single.create { [weak self] single in
            let request = AF.request(URL(string: url)!, method: httpMethod, encoding: JSONEncoding.default).validate().responseData { (response) in
                switch response.result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            print(request.cURLDescription());
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

