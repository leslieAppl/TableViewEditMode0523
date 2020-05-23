# Handle Edit Mode in iOS UITableView

## Set Edit Mode in TableView
- NOTE: DON’T NEED, OTHERWISE THERE GONNA BE BUGS.
        
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
