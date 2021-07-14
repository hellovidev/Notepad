//
//  TableBoardsInteractor.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 09.07.2021.
//

import Foundation
import CoreData

// MARK: - TableBoards Interactor
class TableBoardsInteractor: PresenterToInteractorTableBoardsProtocol {
    var presenter: InteractorToPresenterTableBoardsProtocol?

    func pushBoardsToLocalDatabase(context: NSManagedObjectContext) {
        do {
            try context.save()
            self.presenter?.pushTableBoardsRequestSuccess()
        } catch {
            self.presenter?.pushTableBoardsRequestFailed()
        }
    }
    
    func fetchBoardsFromLocalDatabase(context: NSManagedObjectContext) {
        let request: NSFetchRequest<BoardEntity> = BoardEntity.fetchRequest()
        
        do {
            let boards = try context.fetch(request)
            self.presenter?.fetchTableBoardsRequestSuccess(for: boards)
        } catch {
            self.presenter?.fetchTableBoardsRequestFailed()
        }
    }
}
