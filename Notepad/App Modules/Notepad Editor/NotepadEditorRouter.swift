//
//  NotepadEditorRouter.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import UIKit

class NotepadEditorRouter: PresenterToRouterNotepadEditorProtocol {
    static func createModule() -> NotepadEditorViewController {
        // Elements Creation
        let view = NotepadEditorRouter.mainstoryboard.instantiateViewController(identifier: K.Identifier.Controller.currentNotepad.rawValue) as! NotepadEditorViewController
        var presenter: ViewToPresenterNotepadEditorProtocol & InteractorToPresenterNotepadEditorProtocol = NotepadEditorPresenter()
        var interactor: PresenterToInteractorNotepadEditorProtocol = NotepadEditorInteractor()
        let router: PresenterToRouterNotepadEditorProtocol = NotepadEditorRouter()
        
        // Module Initialization
        view.notepadPresenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: K.Identifier.Storyboard.main.rawValue, bundle: Bundle.main)
    }
}
