//
//  DoDelegate.swift
//  TodoList
//
//  Created by Ador on 2021/04/13.
//

import UIKit

struct TaskObject {
    let title : String
    let content : String
    let category : TaskState
    let id : Int
}

class Delegate: NSObject, UITableViewDelegate {
     
    private var dto: DTOable
   
    init(dto: DTOable) {
        self.dto = dto
    }
    
    func deleteTask(id: Int) {
        AddTaskUseCase().delete(taskId: id) { result in
            if result == true {
                NotificationCenter.default.post(name: .dataReload, object: self)
                NotificationCenter.default.post(name: .countUpdated, object: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 15
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { (action, view, completion) in
            guard let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
            self.deleteTask(id: cell.id)
            completion(true)
        }
        action.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            
            let share = UIAction(title: Text.moveComplete) { [weak self] action in
                guard let task = self?.dto.move(index: indexPath.section) else { return }
                NotificationCenter.default.post(name: .taskCompleted, object: self, userInfo: ["task": task])
            }
            
            let rename = UIAction(title: Text.update) { [weak self] action in
                guard let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
                guard let title = cell.title.text, let contents = cell.content.text else { return }
                let object = TaskObject(title: title, content: contents, category: cell.category, id: cell.id)
                NotificationCenter.default.post(name: .updateTask, object: self, userInfo: ["taskObject": object])
            }
            
            let delete = UIAction(title: Text.delete, attributes: .destructive) { action in
                guard let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
                self.deleteTask(id: cell.id)
            }
            
            return UIMenu(title: "", children: [share, rename, delete])
        }
    }
}