//
//  NotepadEditorViewController.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import UIKit

class NotepadEditorViewController: UIViewController {
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var notepadCurrent: NotepadEntity?
    
    var selectedNotepad: NotepadEntity?
    //var currentBoard: BoardEntity?
    var notepadPresenter: ViewToPresenterNotepadEditorProtocol?

    @IBOutlet weak var notepadTextEditor: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        // Set title to navigation bar
        if let navigationBarTitle = self.selectedNotepad?.id {
            self.navigationItem.title = "Notepad (\(navigationBarTitle))"
            self.notepadTextEditor.text = self.selectedNotepad?.text
        } else {
            self.navigationItem.title = "New Notepad"
        }
        self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height / 4
        
        if let currentText = self.selectedNotepad?.text {
            self.notepadTextEditor.text = currentText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNotepadAction(_ sender: UIButton) {
        if let safeContext = self.context{//, let board = self.currentBoard {
            self.notepadCurrent = NotepadEntity(context: safeContext)
            self.notepadCurrent?.text = self.notepadTextEditor.text
            self.notepadPresenter?.pushNotepadToLocalDatabase(for: BoardEntity(), context: safeContext)
        }
    }
}

extension NotepadEditorViewController: PresenterToViewNotepadEditorProtocol {
    func onPushNotepadResponseSuccess(message: String) {
        print(message)
    }
    
    func onPushNotepadResponseFailed(error: String) {
        print(error)
    }
    
    func onFetchNotepadResponseSuccess(for notepad: NotepadEntity) {
        //selectedNotepad = notepad
    }
    
    func onFetchNotepadResponseFailed(error: String) {
        print(error)
    }
}
