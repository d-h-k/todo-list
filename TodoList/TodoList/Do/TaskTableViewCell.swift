//
//  DoTableViewCell.swift
//  TodoList
//
//  Created by Ador on 2021/04/08.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var author: UILabel!
    var id : Int = 0
    var category : TaskState = .todo
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(task: Task) {
        self.id = task.id
        self.title.text = task.title
        self.content.text = task.contents
        self.author.text = "author by IOS"
        self.category = task.category
    }
}
