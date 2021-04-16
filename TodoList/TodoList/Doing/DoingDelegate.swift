//
//  DoingDelegate.swift
//  TodoList
//
//  Created by Ador on 2021/04/13.
//

import UIKit

class DoingDelegate: NSObject, UITableViewDelegate {
    var handler: ((TaskObject) -> Void)?
    
    override init() {
        self.handler = nil
    }
    
    func updateTask(title: String, contents: String, category : TaskState, id : Int, completion: @escaping (TaskObject) -> Void) {
        completion(TaskObject(title: title, content: contents, category: category, id: id))
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
            // delete api
            DoDTO.shared.delete(index: indexPath.section)
            tableView.deleteSections(IndexSet(indexPath.section...indexPath.section), with: .automatic)
            tableView.reloadData()
            NotificationCenter.default.post(name: .countUpdated, object: self)
            completion(true)
        }
        action.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            
            let share = UIAction(title: Text.moveComplete) { action in
                let task = DoingDTO.shared.move(index: indexPath.section)
                NotificationCenter.default.post(name: .dataReload, object: self, userInfo: ["task": task])
            }
            
            let rename = UIAction(title: Text.update) { [weak self] action in
                guard let handler = self?.handler else { return }
                guard let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
                guard let title = cell.title.text, let contents = cell.content.text else { return }
                self?.updateTask(title: title, contents: contents,category: cell.category, id : cell.id, completion: handler)
            }
            
            let delete = UIAction(title: Text.delete, attributes: .destructive) { action in
                guard let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
                AddTaskUseCase().delete(taskId: cell.id) { result in
                    if result == true {
                        NotificationCenter.default.post(name: .dataReload, object: self)
                        NotificationCenter.default.post(name: .countUpdated, object: self)
                    }
                }
                DoingDTO.shared.delete(index: indexPath.section)
                tableView.deleteSections(IndexSet(indexPath.section...indexPath.section), with: .fade)
                tableView.reloadData()
            }
            
            return UIMenu(title: "", children: [share, rename, delete])
        }
    }
}
