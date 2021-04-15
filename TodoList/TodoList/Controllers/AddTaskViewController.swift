//
//  AddViewController.swift
//  TodoList
//
//  Created by HOONHA CHOI on 2021/04/09.
//

import UIKit

enum CardStatus {
    case add
    case update
}

class AddTaskViewController: UIViewController {
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var positiveButton: CardButton!
    @IBOutlet weak var popUp: UIView!
    
    private var status: CardStatus?
    private var titleName: String?
    private var contents: String?
    private var isKeyboardActive: Bool = false
    private var taskId : Int?
    private var taskCategory : TaskState?
    private let addTaskUseCase = AddTaskUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustPopUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustPopUpDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configure(status : CardStatus, object : TaskObject) {
        self.status = status
        self.titleName = object.title
        self.contents = object.content
        self.taskId = object.id
        self.taskCategory = object.category
    }
    
    func updateUI() {
        status == .update ? setUpdateUI() : ()
    }
    
    func update(status : CardStatus, category : TaskState){
        self.status = status
        self.taskCategory = category
    }
    
    @objc func adjustPopUp(noti: Notification) {
        
        guard isKeyboardActive != true,
              let userInfo = noti.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        popUp.frame.origin.y -= keyboardFrame.height / 3
        isKeyboardActive = true
    }
    
    @objc func adjustPopUpDown(noti: Notification) {
        guard let userInfo = noti.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        popUp.frame.origin.y += keyboardFrame.height / 3
    }
    
    func setUpdateUI() {
        cardTitle.text = "카드 수정"
        positiveButton.setTitle("수정", for: .normal)
        titleTextField.text = titleName
        contentTextField.text = contents
    }
    
    func action() {
        status == .update ? updateTask() : postTask()
    }
    
    func updateTask() {
        guard let taskId = taskId, let category = taskCategory else {
            return
        }
        addTaskUseCase.update(title: titleTextField.text, content: contentTextField.text, category: category, taskId: taskId) {
            self.requestComplete()
        }
    }
    
    func postTask() {
        guard let category = taskCategory else {
            return
        }
        addTaskUseCase.postTask(title: titleTextField.text, content: contentTextField.text, category : category) { _ in
            self.requestComplete()
        }
    }
    
    func requestComplete() {
        NotificationCenter.default.post(name: .dataReload, object: self)
        DispatchQueue.main.async {
            self.dismiss(animated : true)
        }
    }
    
    @IBAction func registerButtonTouched(_ sender: UIButton) {
        action()
    }
    
    @IBAction func closeButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tap(_ sender: Any) {
        titleTextField.resignFirstResponder()
        contentTextField.resignFirstResponder()
    }
}
