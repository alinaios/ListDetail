//
//  Rounting.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

protocol Routing {
    var baseURLString: String { get }
    var method: RequestType { get }
    var routePath: String { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var urlRequest: URLRequest? { get }
}
enum RequestType: String {
    case GET
    case POST
    case PUT
    case DELETE
}
extension Routing {
    var baseURLString: String {
        return "https://pastebin.com"
    }
    
    var method: RequestType {
        return .GET
    }
    
    var routePath: String {
        return ""
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var urlRequest: URLRequest? {
         let baseURLStirng = baseURLString

         guard var url = URL(string: baseURLStirng) else {
 #if DEV
             print("cannot create URL")
 #endif
             return nil
         }

         if !routePath.isEmpty {
             let encoded = routePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
             url.appendPathComponent(encoded ?? "")
         }
         guard let newUrl = URL(string: url.absoluteString.removingPercentEncoding ?? url.absoluteString) else {
 #if DEV
             print("cannot create removingPercentEncoding URL")
 #endif
             return nil
         }

         var urlRequest = URLRequest(url: newUrl)
         urlRequest.httpMethod = method.rawValue

         if let headers = self.headers {
             for (key, value) in headers {
                 urlRequest.addValue(value, forHTTPHeaderField: key)
             }
         }

         return urlRequest
     }
}
