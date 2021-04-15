//
//  DoViewController.swift
//  TodoList
//
//  Created by HOONHA CHOI on 2021/04/06.
//

import UIKit

extension Notification.Name {
    static let taskCompleted = Notification.Name(rawValue: "taskCompleted")
    static let taskDropped = Notification.Name(rawValue: "taskDropped")
    static let activityAdded = Notification.Name(rawValue: "activityAdded")
    static let tableReload = Notification.Name(rawValue: "tableReload")
    static let dataReload = Notification.Name(rawValue: "dataReload")
}
