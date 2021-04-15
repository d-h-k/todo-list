//
//  Router.swift
//  TodoList
//
//  Created by Ador on 2021/04/12.
//

import UIKit

class Router {
    static var shared = Router()
    
    func route(_ storyboard: UIStoryboard, object : TaskObject) -> UIViewController? {
        guard let vc = storyboard.instantiateViewController(withIdentifier: "Add") as? AddTaskViewController else {
            return nil
        }
        vc.configure(status: .update, object : object)
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}
