//
//  ActivityDTO.swift
//  TodoList
//
//  Created by Ador on 2021/04/15.
//

import Foundation

class ActivityDTO {
    static let shared = ActivityDTO()
    
    var activities: [String] = ["1", "2", "3"]
    
    func insert(activity: String) {
        activities.insert(activity, at: 0)
    }
    
}
