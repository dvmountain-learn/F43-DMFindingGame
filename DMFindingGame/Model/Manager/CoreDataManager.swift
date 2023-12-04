//
//  CoreDataManager.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/24/23.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Main")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    /**
     Add the passed score to CoreData.
     */
    func addScore(score: Int) {
        let context = persistentContainer.viewContext
        let scoreEntity = NSEntityDescription.entity(forEntityName: "Score", in: context)!
        let scoreObject = NSManagedObject(entity: scoreEntity, insertInto: context)
        scoreObject.setValue(score, forKey: "score")
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print("Add score an error: \(error.localizedDescription)")
            }
        }
    }
    
    /**
     Retrieve all the scores from CoreData.
     */
    func fetchScores() -> [Score] {
        let request: NSFetchRequest<Score> = Score.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        var scores: [Score] = []
        do {
            scores = try persistentContainer.viewContext.fetch(request)
            
        } catch let error {
            print("Fetch score an error: \(error.localizedDescription)")
        }
        return scores
    }
    
    /**
     Calculate the high score.
     */
    func calculateHighScore() -> Int {
        var highScore: Int = 0
        self.fetchScores().forEach { score in
            if score.score > highScore {
                highScore = Int(score.score)
            }
        }
        return highScore
    }
}
