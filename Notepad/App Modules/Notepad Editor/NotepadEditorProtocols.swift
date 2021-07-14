//
//  NotepadEditorProtocols.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import UIKit
import CoreData

// MARK: - View To Presenter NotepadEditor Protocol
protocol ViewToPresenterNotepadEditorProtocol {
    var view: PresenterToViewNotepadEditorProtocol? { get set }
    var interactor: PresenterToInteractorNotepadEditorProtocol? { get set }
    var router: PresenterToRouterNotepadEditorProtocol? { get set }
    func fetchNotepadFromLocalDatabase(context: NSManagedObjectContext)
    func pushNotepadToLocalDatabase(for selected: BoardEntity, context: NSManagedObjectContext)
}

// MARK: - Presenter To View NotepadEditor Protocol
protocol PresenterToViewNotepadEditorProtocol {
    func onPushNotepadResponseSuccess(message: String)
    func onPushNotepadResponseFailed(error: String)
    func onFetchNotepadResponseSuccess(for notepad: NotepadEntity)
    func onFetchNotepadResponseFailed(error: String)
}

// MARK: - Presenter To Router NotepadEditor Protocol
protocol PresenterToRouterNotepadEditorProtocol {
    static func createModule() -> NotepadEditorViewController
    static var mainstoryboard: UIStoryboard { get }
}

// MARK: - Presenter To Interactor NotepadEditor Protocol
protocol PresenterToInteractorNotepadEditorProtocol {
    var presenter: InteractorToPresenterNotepadEditorProtocol? { get set }
    func fetchNotepadFromLocalDatabase(context: NSManagedObjectContext)
    func pushNotepadToLocalDatabase(for selected: BoardEntity, context: NSManagedObjectContext)
}

// MARK: - Interactor To Presenter NotepadEditor Protocol
protocol InteractorToPresenterNotepadEditorProtocol {
    func pushNotepadRequestSuccess()
    func pushNotepadRequestFailed()
    func fetchNotepadRequestSuccess(for notepad: NotepadEntity)
    func fetchNotepadRequestFailed()
}
