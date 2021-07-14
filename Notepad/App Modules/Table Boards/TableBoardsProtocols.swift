//
//  TableBoardsProtocols.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 09.07.2021.
//

import UIKit
import CoreData

// MARK: - Board Protocol
protocol BoardProtocol: Identifiable, Codable {
    var id: String? { get }
    var title: String? { get set }
}

// MARK: - View To Presenter TableBoards Protocol
protocol ViewToPresenterTableBoardsProtocol {
    var view: PresenterToViewTableBoardsProtocol? { get set }
    var interactor: PresenterToInteractorTableBoardsProtocol? { get set }
    var router: PresenterToRouterTableBoardsProtocol? { get set }
    func fetchBoardsFromLocalDatabase(context: NSManagedObjectContext)
    func pushBoardsToLocalDatabase(context: NSManagedObjectContext)
    func showBoardNotepadsController(for selected: BoardEntity, navigationController: UINavigationController)
}

// MARK: - Presenter To View TableBoards Protocol
protocol PresenterToViewTableBoardsProtocol {
    func onPushTableBoardsResponseSuccess(message: String)
    func onPushTableBoardsResponseFailed(error: String)
    func onFetchTableBoardsResponseSuccess(for boards: [BoardEntity])
    func onFetchTableBoardsResponseFailed(error: String)
}

// MARK: - Presenter To Router TableBoards Protocol
protocol PresenterToRouterTableBoardsProtocol {
    static func createModule() -> TableBoardsViewController
    static var mainstoryboard: UIStoryboard { get }
    func pushToBoardNotepadsScreen(for selected: BoardEntity, navigationConroller: UINavigationController)
}

// MARK: - Presenter To Interactor TableBoards Protocol
protocol PresenterToInteractorTableBoardsProtocol {
    var presenter: InteractorToPresenterTableBoardsProtocol? { get set }
    func fetchBoardsFromLocalDatabase(context: NSManagedObjectContext)
    func pushBoardsToLocalDatabase(context: NSManagedObjectContext)
}

// MARK: - Interactor To Presenter TableBoards Protocol
protocol InteractorToPresenterTableBoardsProtocol {
    func pushTableBoardsRequestSuccess()
    func pushTableBoardsRequestFailed()
    func fetchTableBoardsRequestSuccess(for boards: [BoardEntity])
    func fetchTableBoardsRequestFailed()
}
