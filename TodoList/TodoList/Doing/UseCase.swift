//
//  DoingUseCase.swift
//  TodoList
//
//  Created by Ador on 2021/04/08.
//

import Foundation

class UseCase {

    func loadTasks(completion: @escaping ([Task]) -> Void) {
        URLSessionManager().request(with: .lists, method: .get) { result in
            switch result {
            case .success(let data):
                let tasks = Decoder.decode(task: data)
                completion(tasks ?? [])
            case .failure(_):
                return
            }
        }
    }
    
    func loadDoingTask(completion: @escaping ([Task]) -> Void) {
        URLSessionManager().request(with: .doing, method: .get) { result in
            switch result {
            case .success(let data):
                let tasks = Decoder.decode(task: data)
                completion(tasks ?? [])
            case .failure(_):
                return
            }
        }
    }
    
    func loadDoTask(completion: @escaping ([Task]) -> Void) {
        URLSessionManager().request(with: .todo, method: .get) { result in
            switch result {
            case .success(let data):
                let tasks = Decoder.decode(task: data)
                completion(tasks ?? [])
            case .failure(_):
                return
            }
        }
    }
    
    func loadDoneTask(completion: @escaping ([Task]) -> Void) {
        URLSessionManager().request(with: .done, method: .get) { result in
            switch result {
            case .success(let data):
                let tasks = Decoder.decode(task: data)
                completion(tasks ?? [])
            case .failure(_):
                return
            }
        }
    }
    
    func addTask(body : Data, completion : @escaping (Bool) -> Void) {
        URLSessionManager().requestPost(with: .lists, method: .post, body: body) { result in
            switch result {
            case .success(let data):
                guard let task = Decoder.decode(result: data) else {
                    return
                }
                completion(task)
            case .failure(_):
                return
            }
        }
    }
    
    func updateTask(body : Data, id : Int, completion : @escaping (Task) -> Void) {
        URLSessionManager().requestUpdate(with: .lists, method: .put, body: body , id: id) { result in
            switch result {
            case .success(let data):
                guard let task = Decoder.decode(data: data) else {
                    print("Update Decode Error")
                    return
                }
                completion(task)
            case .failure(_):
                return
            }
        }
    }
}
