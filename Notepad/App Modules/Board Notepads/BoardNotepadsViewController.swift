//
//  BoardNotepadsViewController.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import UIKit

class BoardNotepadsViewController: UITableViewController {
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var notepads: Array<NotepadEntity> = [NotepadEntity]()
    
    var selectedBoard: BoardEntity?
    var boardNotepadsPresenter: ViewToPresenterBoardNotepadsProtocol?

    override func viewWillAppear(_ animated: Bool) {
        // Set title to navigation bar
        if let navigationBarTitle = self.selectedBoard?.title {
            self.navigationItem.title = "Notepads (\(navigationBarTitle))"
        }
        
        // Add new buttton to navigation bar
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.newNotepadAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeContext = self.context {
            boardNotepadsPresenter?.fetchNotepadsFromLocalDatabase(context: safeContext)
        }
    }
    
    // MARK: - TableViewDelegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let safeNavigationController = self.navigationController {
            self.boardNotepadsPresenter?.showNotepadEditorController(for: notepads[indexPath.row], navigationController: safeNavigationController)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notepads.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifier.ReusableCell.notepadCell.rawValue, for: indexPath)
        cell.textLabel?.text = notepads[indexPath.row].text
        return cell
    }
    
    // MARK: - Other Methods
    
    @objc private func newNotepadAction() {
        if let safeNavigationController = self.navigationController {
            self.boardNotepadsPresenter?.showNotepadEditorController(navigationController: safeNavigationController)
        }
    }
}

// MARK: - Extension BoardNotepadsViewController For Presenter To View BoardNotepads Protocol
extension BoardNotepadsViewController: PresenterToViewBoardNotepadsProtocol {
    func onPushNotepadsResponseSuccess(message: String) {
        print(message)
        self.tableView.reloadData()
    }
    
    func onPushNotepadsResponseFailed(error: String) {
        print(error)
    }
    
    func onFetchNotepadsResponseSuccess(for notepads: [NotepadEntity]) {
        self.notepads = notepads
        self.tableView.reloadData()
    }
    
    func onFetchNotepadsResponseFailed(error: String) {
        print(error)
    }
}
