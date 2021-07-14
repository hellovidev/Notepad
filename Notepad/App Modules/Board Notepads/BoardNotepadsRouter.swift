//
//  BoardNotepadsRouter.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import UIKit

// MARK: - BoardNotepads Router
class BoardNotepadsRouter: PresenterToRouterBoardNotepadsProtocol {
    static func createModule() -> BoardNotepadsViewController {
        // Elements Creation
        let view = BoardNotepadsRouter.mainstoryboard.instantiateViewController(identifier: K.Identifier.Controller.tableNotepads.rawValue) as! BoardNotepadsViewController
        var presenter: ViewToPresenterBoardNotepadsProtocol & InteractorToPresenterBoardNotepadsProtocol = BoardNotepadsPresenter()
        var interactor: PresenterToInteractorBoardNotepadsProtocol = BoardNotepadsInteractor()
        let router: PresenterToRouterBoardNotepadsProtocol = BoardNotepadsRouter()
        
        // Module Initialization
        view.boardNotepadsPresenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: K.Identifier.Storyboard.main.rawValue, bundle: Bundle.main)
    }
    
    func pushToNotepadEditorScreen(for selected: NotepadEntity? = nil, navigationConroller: UINavigationController) {
        let notepadEditorModule = NotepadEditorRouter.createModule()
        notepadEditorModule.selectedNotepad = selected
        navigationConroller.pushViewController(notepadEditorModule, animated: true)
    }
}
