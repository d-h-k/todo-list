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
    
    func updateEncode(title : String?, content : String?, cetagory : TaskState) -> Data? {
        guard let title = title, let content = content else {
            return nil
        }
        return Task(title: title, contents: content, category: cetagory).encode()
    }
    
    func postTask(title : String?, content : String?, completion : @escaping (Bool) -> Void) {
        guard let data = self.encode(title: title, content: content) else {
            return
        }
        UseCase().addTask(body: data) { (result) in
            completion(result)
        }
    }
    
    func update(title : String?, content : String?, category : TaskState, taskId: Int, completion : @escaping () -> Void) {
        guard let data = self.updateEncode(title: title , content: content, cetagory: category) else {
            return
        }
        UseCase().updateTask(body: data, id: taskId) { (result) in
            print(result)
            completion()
        }
        
    }
}
