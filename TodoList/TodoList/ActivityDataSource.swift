//
//  ActivityDataSource.swift
//  TodoList
//
//  Created by Ador on 2021/04/15.
//

import UIKit

class ActivityTableViewDataSource : NSObject, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActivityDTO.shared.activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityViewCell.identifier, for: indexPath) as? ActivityViewCell else {
            return UITableViewCell()
        }
        cell.register(string: ActivityDTO.shared.activities[indexPath.row])
        return cell
    }
}
