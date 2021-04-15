//
//  AddTaskUseCase.swift
//  TodoList
//
//  Created by HOONHA CHOI on 2021/04/14.
//

import Foundation

class AddTaskUseCase {
    
    func encode(title : String?, content : String?) -> Data? {
        guard let title = title, let content = content else {
            return nil
        }
        return Task(title: title, contents: content, category: TaskState.todo).encode()
    }
    
    func postTask(title : String?, content : String?, completion : @escaping (Bool) -> Void) {
        guard let data = self.encode(title: title, content: content) else {
            return
        }
        UseCase().postTask(body: data) { (result) in
            completion(result)
        }
    }

}
