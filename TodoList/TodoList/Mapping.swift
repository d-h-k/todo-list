//
//  Mapping.swift
//  TodoList
//
//  Created by HOONHA CHOI on 2021/04/15.
//

import UIKit

class Mapping {
    private let taskState : [TaskState] = [.todo, .progress, .done]
    private var map : [UIButton : TaskState] = [:]
    
    init(buttons : [UIButton]) {
        map = [:]
        self.map = Dictionary(uniqueKeysWithValues: zip(buttons, taskState))
    }
    subscript(button : UIButton) -> TaskState? {
        return map[button]
    }
}
