//
//  MainViewController.swift
//  TodoList
//
//  Created by Ador on 2021/04/13.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityTableView: UITableView!
    
    @IBOutlet var addButtons: [UIButton]!
    
    private let activityWidth : CGFloat = 428
    
    private let doDataSource = DoDataSource()
    private let doDelegate = DoDelegate()
    private let doDragDelegate = DoDragDelegate()
    private let doDropDelegate = DoDropDelegate()
    
    private let doingDataSource = DoingDataSource()
    private let doingDelegate = DoingDelegate()
    private let doingDragDelegate = DoingDragDelegate()
    private let doingDropDelegate = DoingDropDelegate()
    
    private let doneDataSource = DoneDataSource()
    private let doneDelegate = DoneDelegate()
    private let doneDragDelegate = DoneDragDelegate()
    private let doneDropDelegate = DoneDropDelegate()
    
    private let activityDataSource = ActivityTableViewDataSource()
    private var addButton : Mapping!

    private var taskDTO = TaskDTO()
    
    lazy var closure : ((TaskObject) -> Void) = { object in
        guard let storyBoard = self.storyboard else {
            return
        }
        guard let vc = Router.shared.route(storyBoard, object: object) else {
            return
        }
        self.present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityTrailingConstraint.constant -= activityWidth
        setDelegateHandler()

        activityTableView.register(UINib(nibName: "ActivityViewCell", bundle: nil), forCellReuseIdentifier: ActivityViewCell.identifier)
        activityTableView.dataSource = activityDataSource
        NotificationCenter.default.addObserver(self, selector: #selector(activityTableViewReload), name: .activityAdded, object: nil)

        addButton = Mapping(buttons: addButtons)
        
        loadTask()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .dataReload, object: nil)
    }

    @objc func reload() {
        loadTask()
    }
    
    @objc func activityTableViewReload() {
        DispatchQueue.main.async {
            self.activityTableView.reloadData()
        }
    }
    
    func setDelegateHandler() {
        doDelegate.handler = closure
        doingDelegate.handler = closure
        doneDelegate.handler = closure
    }
    
    func loadTask(){
        UseCase().loadTasks { [weak self] tasks in
            self?.taskDTO.filter(tasks: tasks)
            DoDTO.shared.update(tasks : self?.taskDTO.todos ?? [])
            DoingDTO.shared.update(tasks : self?.taskDTO.doing ?? [])
            DoneDTO.shared.update(tasks : self?.taskDTO.done ?? [])
            NotificationCenter.default.post(name: .tableReload, object: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? TaskViewController else { return }
        switch segue.identifier {
        case "ToDo":
            vc.dataSource = doDataSource
            vc.delegate = doDelegate
            vc.dragDelegate = doDragDelegate
            vc.dropDelegate = doDropDelegate
        case "Doing":
            vc.dataSource = doingDataSource
            vc.delegate = doingDelegate
            vc.dragDelegate = doingDragDelegate
            vc.dropDelegate = doingDropDelegate
        case "Done":
            vc.dataSource = doneDataSource
            vc.delegate = doneDelegate
            vc.dragDelegate = doneDragDelegate
            vc.dropDelegate = doneDropDelegate
        default:
            break
        }
    }

    // MARK: - IBActions
    @IBAction func touchUpAdd(_ sender: UIButton) {
        guard let category = addButton[sender] else {
            return
        }
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Add") as? AddTaskViewController else {
            return
        }
        vc.update(status : .add, category : category)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func touchUpMenu(_ sender: Any) {
        activityTrailingConstraint.constant = 0
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @IBAction func touchUpClose(_ sender: Any) {
        activityTrailingConstraint.constant -= activityWidth
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
