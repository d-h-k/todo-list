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
    
    lazy var closure : ((String,String) -> Void) = { title, contents in
        guard let storyBoard = self.storyboard else {
            return
        }
        guard let vc = Router.shared.route(storyBoard, title: title, contents: contents) else {
            return
        }
        self.present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityTrailingConstraint.constant -= activityWidth
        setDelegateHandler()
    }

    func setDelegateHandler() {
        doDelegate.handler = closure
        doingDelegate.handler = closure
        doneDelegate.handler = closure
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
    @IBAction func touchUpAdd(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Add") as? AddTaskViewController else {
            return
        }
        vc.update(status : .add)
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
