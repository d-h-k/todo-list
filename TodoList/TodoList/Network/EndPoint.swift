//
//  EndPoint.swift
//  TodoList
//
//  Created by Ador on 2021/04/08.
//

import Foundation

enum EndPoint {
    private static let scheme = "http"
    private static let host = "13.209.4.14"
    
    static func url(with path: Path) -> URL? {
        var components = URLComponents()
        components.scheme = EndPoint.scheme
        components.port = 8080
        components.host = EndPoint.host
        components.path = path.rawValue
        return components.url
    }
    
    static func updateUrl(with path: Path, id : Int) -> URL? {
        var components = URLComponents()
        components.scheme = EndPoint.scheme
        components.port = 8080
        components.host = EndPoint.host
        components.path = path.rawValue + "/\(id)"
        return components.url
    }
    
    static let headers: [String: String] = ["application/json": "Content-Type"]
}

enum Path: String {
    case lists = "/board/lists"
    case todo = "/board/todo"
    case doing = "/board/progress"
    case done = "/board/done"
}
    
