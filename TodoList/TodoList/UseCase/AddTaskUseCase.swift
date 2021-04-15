//
//  AddTaskUseCase.swift
//  TodoList
//
//  Created by HOONHA CHOI on 2021/04/14.
//

import Foundation

class AddTaskUseCase {
    
    func postTask(title : String?, content : String?, category: TaskState, completion : @escaping (Bool) -> Void) {
        guard let data = self.encode(title: title, content: content, category : category) else {
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
            completion()
        }
    }
    
    private func encode(title : String?, content : String?, category : TaskState) -> Data? {
        guard let title = title, let content = content else {
            return nil
        }
        return Task(title: title, contents: content, category: category).encode()
    }
    
    private func updateEncode(title : String?, content : String?, cetagory : TaskState) -> Data? {
        guard let title = title, let content = content else {
            return nil
        }
        return Task(title: title, contents: content, category: cetagory).encode()
    }

}
