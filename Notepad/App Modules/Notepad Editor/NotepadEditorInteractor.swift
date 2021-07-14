//
//  NotepadEditorInteractor.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 12.07.2021.
//

import Foundation
import CoreData

class NotepadEditorInteractor: PresenterToInteractorNotepadEditorProtocol {
    var presenter: InteractorToPresenterNotepadEditorProtocol?
    
    func fetchNotepadFromLocalDatabase(context: NSManagedObjectContext) {
        do {
            try context.save()
            self.presenter?.pushNotepadRequestSuccess()
        } catch {
            self.presenter?.pushNotepadRequestFailed()
        }
    }
    
    func pushNotepadToLocalDatabase(for selected: BoardEntity, context: NSManagedObjectContext) {
        let notepadPredicate = NSPredicate(format: "parentBoard.title MATCHES %@", selected.title!)
        if let additionalPredicate = predicate {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [boardPredicate, additionalPredicate])
            request.predicate = compoundPredicate
        } else {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [boardPredicate])
            request.predicate = compoundPredicate
        }

        let request: NSFetchRequest<NotepadEntity> = NotepadEntity.fetchRequest()

        do {
            let notepad = try context.fetch(request)
            self.presenter?.fetchNotepadRequestSuccess(for: notepad)
        } catch {
            self.presenter?.fetchNotepadRequestFailed()
        }
        self.presenter?.fetchNotepadRequestFailed()
    }
}


