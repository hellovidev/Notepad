//
//  TableBoardsRouter.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 09.07.2021.
//

import UIKit

// MARK: - TableBoards Router
class TableBoardsRouter: PresenterToRouterTableBoardsProtocol {
    static func createModule() -> TableBoardsViewController {
        // Elements Creation
        let view = TableBoardsRouter.mainstoryboard.instantiateViewController(identifier: K.Identifier.Controller.tableBoards.rawValue) as! TableBoardsViewController
        var presenter: ViewToPresenterTableBoardsProtocol & InteractorToPresenterTableBoardsProtocol = TableBoardsPresenter()
        var interactor: PresenterToInteractorTableBoardsProtocol = TableBoardsInteractor()
        let router: PresenterToRouterTableBoardsProtocol = TableBoardsRouter()
        
        // Module Initialization
        view.tableBoardsPresenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: K.Identifier.Storyboard.main.rawValue, bundle: Bundle.main)
    }
    
    func pushToBoardNotepadsScreen(for selected: BoardEntity, navigationConroller: UINavigationController) {
        let boardNotepadsModule = BoardNotepadsRouter.createModule()
        boardNotepadsModule.selectedBoard = selected
        navigationConroller.pushViewController(boardNotepadsModule, animated: true)
    }
}
