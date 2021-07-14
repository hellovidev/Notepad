//
//  BoardNotepadsInteractor.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import Foundation
import CoreData

class BoardNotepadsInteractor: PresenterToInteractorBoardNotepadsProtocol {
    var presenter: InteractorToPresenterBoardNotepadsProtocol?
    
    func fetchNotepadsFromLocalDatabase(context: NSManagedObjectContext) {
        do {
            try context.save()
            self.presenter?.pushNotepadsRequestSuccess()
        } catch {
            self.presenter?.pushNotepadsRequestFailed()
        }
    }
    
    func pushNotepadsToLocalDatabase(context: NSManagedObjectContext) {
        let request: NSFetchRequest<NotepadEntity> = NotepadEntity.fetchRequest()
        
        do {
            let notepads = try context.fetch(request)
            self.presenter?.fetchNotepadsRequestSuccess(for: notepads)
        } catch {
            self.presenter?.fetchNotepadsRequestFailed()
        }
    }
}
