//
//  DoDataSource.swift
//  TodoList
//
//  Created by Ador on 2021/04/08.
//

import UIKit

class DataSource : NSObject {
    private var dto: DTOable
    
    init(dto: DTOable) {
        self.dto = dto
    }
}

extension DataSource : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        return 1
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return dto.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        let task = dto.configure(index: indexPath.section)
        cell.configure(task: task)

        return cell
    }
}
