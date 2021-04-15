//
//  ActivityViewCell.swift
//  TodoList
//
//  Created by Ador on 2021/04/15.
//

import UIKit

class ActivityViewCell: UITableViewCell {
    
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var log: UILabel!
    
    static let identifier = "ActivityViewCell"
    
    func register(string: String) {
        contents.text = "해야할 일에 \(string)(을)를 등록하였습니다."
    }
}
