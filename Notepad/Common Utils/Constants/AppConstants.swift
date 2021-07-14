//
//  AppConstants.swift
//  Notepad
//
//  Created by Sergei Romanchuk on 09.07.2021.
//

import Foundation

// MARK: - App Constants
enum K {
    
    // MARK: - Identifiers
    enum Identifier {
        
        // MARK: - Controller Ids
        enum Controller: String {
            case tableBoards = "TableBoardsViewController"
            case tableNotepads = "BoardNotepadsViewController"
            case currentNotepad = "NotepadEditorViewController"
        }
        
        // MARK: - Storyboard Ids
        enum Storyboard: String {
            case main = "Main"
            case launchScreen = "LaunchScreen"
        }
        
        // MARK: - Reusable Cell Ids
        enum ReusableCell: String {
            case boardCell = "BoardCell"
            case notepadCell = "NotepadCell"
        }
    }
    
    // MARK: - Core Data
    enum CoreData {
        
        // MARK: - Errors
        enum Error: String {
            case pushBoardsError = "Push boards to local database failed."
            case fetchBoardsError = "Fetch boards from local database failed."
            case pushNotepadsError = "Push notepads to local database failed."
            case fetchNotepadsError = "Fetch notepads from local database failed."
            case pushCurrentNotepadError = "Push current notepad to local database failed."
            case fetchCurrentNotepadError = "Fetch current notepad from local database failed."
        }
        
        // MARK: - Success Messages
        enum Success: String {
            case pushBoardsSuccess = "Push boards data to local database completed successful."
            case pushNotepadsSuccess = "Push notepads data to local database completed successful."
            case pushCurrentNotepadSuccess = "Push current notepad data to local database completed successful."
        }
    }
}
