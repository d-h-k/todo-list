//
//  DoneDelegate.swift
//  TodoList
//
//  Created by Ador on 2021/04/13.
//

import UIKit

class DoneDelegate: NSObject, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            
            let share = UIAction(title: Text.moveComplete) { action in
                let task = DoDTO.shared.move(index: indexPath.section)
                NotificationCenter.default.post(name: .taskCompleted, object: self, userInfo: ["task": task])
            }
            
            let rename = UIAction(title: Text.update) { [weak self] action in
                //
                guard let handler = self?.handler else { return }
                guard let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
                guard let title = cell.title.text, let contents = cell.content.text else { return }
                self?.updateTask(title: title, contents: contents,category: cell.category, id : cell.id, completion: handler)
            }
            
            let delete = UIAction(title: Text.delete, attributes: .destructive) { action in
                // Perform delete API
                DoneDTO.shared.delete(index: indexPath.section)
                tableView.deleteSections(IndexSet(indexPath.section...indexPath.section), with: .fade)
                tableView.reloadData()
            }
            
            return UIMenu(title: "", children: [share, rename, delete])
        }
    }
}
