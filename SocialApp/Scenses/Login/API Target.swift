//
//  API Target.swift
//  SocialApp
//
//  Created by Andy on 20/09/2024.
//

import UIKit
import Moya

enum APITarget: TargetType {
    
    case logIn(email: String, password: String)
    case getInforbySegment
    case getTopicDiscovery
    case getCollectionDiscovery
    case getActivity
    case getUserCollection
    
    
    var baseURL: URL {
        switch self {
        case .logIn:
            return URL(string: "https://5f9d01ef-361b-4aae-a229-f67b9db1e7cd.mock.pstmn.io")!
        case .getInforbySegment:
            return URL(string: "https://d4f3c553-e7c3-4a49-aea3-945dc7641023.mock.pstmn.io")!
        case .getTopicDiscovery:
            return URL(string: "https://689099a1-335c-412e-88e1-80f66b272781.mock.pstmn.io")!
        case .getCollectionDiscovery:
            return URL(string: "https://689099a1-335c-412e-88e1-80f66b272781.mock.pstmn.io")!
        case .getActivity:
            return URL(string: "https://88309f41-7b81-4429-9ba7-3cdbee421ded.mock.pstmn.io")!
        case .getUserCollection:
            return URL(string: "https://a0aca2a3-c357-458b-8b74-ac535a2a2fa7.mock.pstmn.io")!
        }
    }
    
    var path: String {
        switch self {
        case .logIn:
            return "/login"
        case .getInforbySegment:
            return "/home"
        case .getTopicDiscovery:
            return "/topic"
        case .getCollectionDiscovery:
            return "/collection"
        case .getActivity:
            return "/activity"
        case .getUserCollection:
            return "/userProfile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logIn:
            return .post
        case .getInforbySegment, .getTopicDiscovery, .getCollectionDiscovery, .getActivity, .getUserCollection:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .logIn(let email, let password):
            return .requestParameters(parameters: ["email": email,
                                                   "passWord": password], encoding: JSONEncoding.default)
        case .getInforbySegment, .getTopicDiscovery, .getCollectionDiscovery, .getActivity, .getUserCollection:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
       
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(SessionManager.shared.token)"]
    }
    
}

