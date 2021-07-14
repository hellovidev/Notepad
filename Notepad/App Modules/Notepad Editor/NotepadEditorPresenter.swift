//
//  NotepadEditorPresenter.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import Foundation
import CoreData

class NotepadEditorPresenter: ViewToPresenterNotepadEditorProtocol {
    var view: PresenterToViewNotepadEditorProtocol?
    var interactor: PresenterToInteractorNotepadEditorProtocol?
    var router: PresenterToRouterNotepadEditorProtocol?
    
    func fetchNotepadFromLocalDatabase(context: NSManagedObjectContext) {
        self.interactor?.fetchNotepadFromLocalDatabase(context: context)
    }
    
    func pushNotepadToLocalDatabase(for selected: BoardEntity, context: NSManagedObjectContext) {
        self.interactor?.fetchNotepadFromLocalDatabase(context: context)
    }
}

extension NotepadEditorPresenter: InteractorToPresenterNotepadEditorProtocol {
    func pushNotepadRequestSuccess() {
        self.view?.onPushNotepadResponseSuccess(message: K.CoreData.Success.pushCurrentNotepadSuccess.rawValue)
    }
    
    func pushNotepadRequestFailed() {
        self.view?.onPushNotepadResponseFailed(error: K.CoreData.Error.pushCurrentNotepadError.rawValue)
    }
    
    func fetchNotepadRequestSuccess(for notepad: NotepadEntity) {
        self.view?.onFetchNotepadResponseSuccess(for: notepad)
    }
    
    func fetchNotepadRequestFailed() {
        self.view?.onFetchNotepadResponseFailed(error: K.CoreData.Error.fetchCurrentNotepadError.rawValue)
    }
}
