//
//  URLSessionManager.swift
//  TodoList
//
//  Created by Ador on 2021/04/08.
//

import Foundation

struct URLSessionManager {
    
    func request(with url: Path, method : HTTPMethod, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlRequest = makeURLRequest(with: url, method: method, body: nil) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, res, error in
            guard let data = data, error == nil else {
                return
            }
            guard let response = res as? HTTPURLResponse,
                  response.statusCode == 200 else {
                return
            }
            completion(.success(data))
        }).resume()
    }
    
    func requestPost(with url: Path, method : HTTPMethod, body : Data, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlRequest = makeURLRequest(with: url, method: method, body: body) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, res, error in
            guard let data = data, error == nil else {
                return
            }
            guard let response = res as? HTTPURLResponse,
                  response.statusCode == 200 else {
                return
            }
            completion(.success(data))
        }).resume()
    }
    
    func requestUpdate(with url: Path, method : HTTPMethod, body : Data, id : Int, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlRequest = makeUpdateURLRequest(with: url, method: method, body: body, id : id) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, res, error in
            guard let data = data, error == nil else {
                return
            }
            guard let response = res as? HTTPURLResponse,
                  response.statusCode == 200 else {
                return
            }
            completion(.success(data))
        }).resume()
    }
    
    private func makeURLRequest(with path : Path, method : HTTPMethod, body : Data?) -> URLRequest? {
        guard let url = EndPoint.url(with: path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        EndPoint.headers.forEach {
            request.setValue($0, forHTTPHeaderField: $1)
        }
        return request
    }
    
    private func makeUpdateURLRequest(with path : Path, method : HTTPMethod, body : Data?, id : Int) -> URLRequest? {
        guard let url = EndPoint.updateUrl(with: path, id : id) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        EndPoint.headers.forEach {
            request.setValue($0, forHTTPHeaderField: $1)
        }
        return request
    }
}
