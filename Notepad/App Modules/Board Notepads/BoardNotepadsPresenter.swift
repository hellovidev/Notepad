//
//  BoardNotepadsPresenter.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import UIKit
import CoreData

// MARK: - BoardNotepads Presenter
class BoardNotepadsPresenter: ViewToPresenterBoardNotepadsProtocol {
    var view: PresenterToViewBoardNotepadsProtocol?
    var interactor: PresenterToInteractorBoardNotepadsProtocol?
    var router: PresenterToRouterBoardNotepadsProtocol?
    
    func fetchNotepadsFromLocalDatabase(context: NSManagedObjectContext) {
        self.interactor?.fetchNotepadsFromLocalDatabase(context: context)
    }
    
    func pushNotepadsToLocalDatabase(context: NSManagedObjectContext) {
        self.interactor?.pushNotepadsToLocalDatabase(context: context)
    }
    
    func showNotepadEditorController(for selected: NotepadEntity? = nil, navigationController: UINavigationController) {
        self.router?.pushToNotepadEditorScreen(for: selected, navigationConroller: navigationController)
    }
}

extension BoardNotepadsPresenter: InteractorToPresenterBoardNotepadsProtocol {
    func pushNotepadsRequestSuccess() {
        self.view?.onPushNotepadsResponseSuccess(message: K.CoreData.Success.pushNotepadsSuccess.rawValue)
    }
    
    func pushNotepadsRequestFailed() {
        self.view?.onPushNotepadsResponseFailed(error: K.CoreData.Error.pushNotepadsError.rawValue)
    }
    
    func fetchNotepadsRequestSuccess(for notepads: [NotepadEntity]) {
        self.view?.onFetchNotepadsResponseSuccess(for: notepads)
    }
    
    func fetchNotepadsRequestFailed() {
        self.view?.onFetchNotepadsResponseFailed(error: K.CoreData.Error.fetchNotepadsError.rawValue)
    }
}
