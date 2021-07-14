//
//  TableBoardsPresenter.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 09.07.2021.
//

import UIKit
import CoreData

// MARK: - TableBoards Presenter
class TableBoardsPresenter: ViewToPresenterTableBoardsProtocol {
    var view: PresenterToViewTableBoardsProtocol?
    var interactor: PresenterToInteractorTableBoardsProtocol?
    var router: PresenterToRouterTableBoardsProtocol?
    
    func fetchBoardsFromLocalDatabase(context: NSManagedObjectContext) {
        interactor?.fetchBoardsFromLocalDatabase(context: context)
    }
    
    func pushBoardsToLocalDatabase(context: NSManagedObjectContext) {
        interactor?.pushBoardsToLocalDatabase(context: context)
    }
    
    func showBoardNotepadsController(for selected: BoardEntity, navigationController: UINavigationController) {
        self.router?.pushToBoardNotepadsScreen(for: selected, navigationConroller: navigationController)
    }
}

// MARK: - Extension TableBoards Presenter For Interactor To Presenter TableBoards Protocol
extension TableBoardsPresenter: InteractorToPresenterTableBoardsProtocol {
    func pushTableBoardsRequestSuccess() {
        view?.onPushTableBoardsResponseSuccess(message: K.CoreData.Success.pushBoardsSuccess.rawValue)
    }
    
    func pushTableBoardsRequestFailed() {
        view?.onPushTableBoardsResponseFailed(error: K.CoreData.Error.pushBoardsError.rawValue)
    }
    
    func fetchTableBoardsRequestSuccess(for boards: [BoardEntity]) {
        view?.onFetchTableBoardsResponseSuccess(for: boards)
    }
    
    func fetchTableBoardsRequestFailed() {
        view?.onFetchTableBoardsResponseFailed(error: K.CoreData.Error.fetchBoardsError.rawValue)
    }
}
