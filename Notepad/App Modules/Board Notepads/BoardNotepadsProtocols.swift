//
//  BoardNotepadsProtocols.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import UIKit
import CoreData

// MARK: - Notepad Protocol
protocol NotepadProtocol: Identifiable, Codable {
    var id: String? { get }
    var text: String? { get set }
}

// MARK: - View To Presenter BoardNotepads Protocol
protocol ViewToPresenterBoardNotepadsProtocol {
    var view: PresenterToViewBoardNotepadsProtocol? { get set }
    var interactor: PresenterToInteractorBoardNotepadsProtocol? { get set }
    var router: PresenterToRouterBoardNotepadsProtocol? { get set }
    func fetchNotepadsFromLocalDatabase(context: NSManagedObjectContext)
    func pushNotepadsToLocalDatabase(context: NSManagedObjectContext)
    func showNotepadEditorController(for selected: NotepadEntity?, navigationController: UINavigationController)
}

extension ViewToPresenterBoardNotepadsProtocol {
    func showNotepadEditorController(for selected: NotepadEntity? = nil, navigationController: UINavigationController) {
        showNotepadEditorController(for: selected, navigationController: navigationController)
    }
}

// MARK: - Presenter To View BoardNotepads Protocol
protocol PresenterToViewBoardNotepadsProtocol {
    func onPushNotepadsResponseSuccess(message: String)
    func onPushNotepadsResponseFailed(error: String)
    func onFetchNotepadsResponseSuccess(for notepads: [NotepadEntity])
    func onFetchNotepadsResponseFailed(error: String)
}

// MARK: - Presenter To Router BoardNotepads Protocol
protocol PresenterToRouterBoardNotepadsProtocol {
    static func createModule() -> BoardNotepadsViewController
    static var mainstoryboard: UIStoryboard { get }
    func pushToNotepadEditorScreen(for selected: NotepadEntity?, navigationConroller: UINavigationController)
}

extension PresenterToRouterBoardNotepadsProtocol {
    func pushToNotepadEditorScreen(for selected: NotepadEntity? = nil, navigationConroller: UINavigationController) {
        return pushToNotepadEditorScreen(for: selected, navigationConroller: navigationConroller)
    }
}

// MARK: - Presenter To Interactor BoardNotepads Protocol
protocol PresenterToInteractorBoardNotepadsProtocol {
    var presenter: InteractorToPresenterBoardNotepadsProtocol? { get set }
    func fetchNotepadsFromLocalDatabase(context: NSManagedObjectContext)
    func pushNotepadsToLocalDatabase(context: NSManagedObjectContext)
}

// MARK: - Interactor To Presenter BoardNotepads Protocol
protocol InteractorToPresenterBoardNotepadsProtocol {
    func pushNotepadsRequestSuccess()
    func pushNotepadsRequestFailed()
    func fetchNotepadsRequestSuccess(for notepads: [NotepadEntity])
    func fetchNotepadsRequestFailed()
}
