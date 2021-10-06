//
//  File.swift
//  
//
//  Created by Alan Yan on 2019-12-03.
//

#if canImport(UIKit)
import UIKit

open class AYTableViewCell<T>: UITableViewCell {
    
    open var data: T!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class AYTableView<T, C: AYTableViewCell<T>>: UITableViewController {
    
    open var dataSet = [T]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    open var height:CGFloat = 100 {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(C.self, forCellReuseIdentifier: "cell")
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        guard let newCell = cell as? C else {
            return cell
        }
        
        
        return newCell
        
        
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
}


#endif
