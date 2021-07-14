//
//  ViewController.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 09.07.2021.
//

import UIKit

class TableBoardsViewController: UITableViewController {
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var tableBoardsPresenter: ViewToPresenterTableBoardsProtocol?
    var boards: Array<BoardEntity> = [BoardEntity]()

    override func viewWillAppear(_ animated: Bool) {
        // Set title tonavigation bar
        self.navigationItem.title = "Notepad boards"
        
        // Add new buttton to navigation bar
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.newBoardAction(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let safeContext = self.context {
            tableBoardsPresenter?.fetchBoardsFromLocalDatabase(context: safeContext)
        }
    }
    
    @IBAction func newBoardAction(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New board creation", message: "Input board name", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add new board", style: .default, handler: { _ in
            if let safeContext = self.context {
                let newBoard = BoardEntity(context: safeContext)
                
                if let boardTitle = textField.text {
                    newBoard.title = boardTitle
                    self.boards.append(newBoard)
                    self.tableBoardsPresenter?.pushBoardsToLocalDatabase(context: safeContext)
                }
            }
        })
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new board..."
            textField = alertTextField
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let safeNavigationController = self.navigationController {
            self.tableBoardsPresenter?.showBoardNotepadsController(for: boards[indexPath.row], navigationController: safeNavigationController)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifier.ReusableCell.boardCell.rawValue, for: indexPath)
        cell.textLabel?.text = boards[indexPath.row].title
        return cell
    }
}

// MARK: - Extension Sign Up View Controller For Presenter To View Sign Up Protocol
extension TableBoardsViewController: PresenterToViewTableBoardsProtocol {
    func onPushTableBoardsResponseSuccess(message: String) {
        print("Success: \(message)")
        self.tableView.reloadData()
    }
    
    func onPushTableBoardsResponseFailed(error: String) {
        print("Error: \(error)")
    }
    
    func onFetchTableBoardsResponseSuccess(for boards: [BoardEntity]) {
        self.boards = boards
        self.tableView.reloadData()
    }
    
    func onFetchTableBoardsResponseFailed(error: String) {
        print("Error: \(error)")
    }
}
