//
//  TaskViewController.swift
//  TodoList
//
//  Created by Ador on 2021/04/13.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet weak var taskTableView: UITableView!
    
    var dataSource: UITableViewDataSource?
    var delegate: UITableViewDelegate?
    var dropDelegate: UITableViewDropDelegate?
    var dragDelegate: UITableViewDragDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.separatorStyle = .none
        taskTableView.estimatedRowHeight = 108
        taskTableView.rowHeight = UITableView.automaticDimension
        taskTableView.dragInteractionEnabled = true
        
        taskTableView.dataSource = dataSource
        taskTableView.delegate = delegate
        taskTableView.dragDelegate = dragDelegate
        taskTableView.dropDelegate = dropDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .tableReload, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .taskDropped, object: nil)
    }
    
    @objc func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.taskTableView.reloadData()
        }
    }
    
}
