//
//  ViewController.swift
//  TableView0523
//
//  Created by leslie on 5/23/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var objects:[String]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        objects = []
        
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        //Disable right bar add button in edit mode
        if !tableView.isEditing {
            objects.insert("\(objects.count)", at: 0)
            tableView.reloadData()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        //Edit button toggling between edit mode
        if editing {
            tableView.isEditing = true
        }
        else {
            tableView.isEditing = false
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCell
        cell.textLabel?.text = objects[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //Only allow delete rows in edit mode with delete button
        if isEditing {
            return true
        }
        //Disable swipe to delele action.
        //Swipe to delete action conflicts with edit mode.
        //When swiped to delete the last row in table view
        //you will miss delete button in edit mode
        //after you added a new row with insert button.
        else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
        }
        else if editingStyle == .insert {
            objects.insert("\(objects.count)", at: 0)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //move row from sourceIndexPath to destinationIndexPath corresponding with data model
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //If in the edit mode
        if tableView.isEditing {
            if indexPath.row == 0 {
                return .insert
            }
            else {
                return .delete
            }
        }
        //If not in the edit mode
        else {
            return .delete
        }
    }
}
