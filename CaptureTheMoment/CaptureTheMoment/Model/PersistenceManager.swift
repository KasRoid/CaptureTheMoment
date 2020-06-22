//
//  PersistenceManager.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/22/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit
import CoreData

final class PersistenceManager {
    
    private init(){}
    static let shared = PersistenceManager()
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataManager")
        container.loadPersistentStores(
            completionHandler: {(storeDescription, error) in
                print(storeDescription)
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }})
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    
    // MARK: - Core Data Saving Support
    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved Successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Methods
    func saveData(imageView: UIImageView, textField: UITextField) {
        let photo = Photo(context: self.context)
        photo.image = imageView.image?.pngData()
        photo.comment = textField.text
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        }
        catch {
            print(error)
            return []
        }
    }
    
    func loadPhotoData() {
//        guard let photo = try! self.context.fetch(Photo.fetchRequest()) as? [Photo] else { return }
        let photo = self.fetch(Photo.self)
        photo.forEach() { print($0.comment ?? "")}
    }
}
