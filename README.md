# Handle Edit Mode in iOS UITableView

## Set Edit Mode in TableView
- Asks the data source to commit the insertion or deletion of a specified row
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                data.remove(at: indexPath.row)
            }
            else if editingStyle == .insert {
                data.append(String(indexPath.row))
            }
            tableView.reloadData()
        }

- NOTE: ONLY MODIFY DATA MODEL, AND THEN RELOAD TABLE VIEW DATA. DON’T MODIFY TABLE VIEW WITH THE METHODS BELOW. OTHERWISE THERE GONNA BE BUGS
        
        tableView.deleteRows(at indexPaths: with animation:)
        tableView.insertRows(at indexPaths: with animation:)

- Make sure the last row is not .insert mode when the table view is not in the editing mode
        
        extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            //Make sure the last row is not .insert mode when the table view is not in the editing mode
            if tableView.isEditing {
                if indexPath.row == data.count-1 {
                    return .insert
                }
                else {
                    return .delete
                }
            }
            else {
                return .delete
            }
        }

## Show re-order control in TableView Edit mode
        
        func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            //move row from sourceIndexPath to destinationIndexPath corresponding with data model
        }

## Navigation Left | Right Bar Button Item
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            
            data = ["1", "2", "3"]
            
            // Do any additional setup after loading the view.
            navigationItem.leftBarButtonItem = editButtonItem

            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
            navigationItem.rightBarButtonItem = addButton
            
        }
        
        @objc
        func insertNewObject(_ sender: Any) {
            data.insert("0", at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }

