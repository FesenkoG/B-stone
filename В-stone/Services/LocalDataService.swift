//
//  LocalDataService.swift
//  В-stone
//
//  Created by Георгий Фесенко on 11.06.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import Foundation
import CoreData

public class LocalDataService {
    private lazy var container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchBluetoothData() -> Result<BluetoothModel> {
        do {
            let request = NSFetchRequest<BluetoothUserData>()
            let bluetoothData = try container.viewContext.fetch(request)
            let model = BluetoothModel()
            //transformation to native struct
            
            return Result.success(model)
        } catch {
            return Result.failure(error)
        }
    }
    
    func fetchQuizData() -> Result<QuizModel> {
        do {
            let request = NSFetchRequest<QuizUserData>()
            let quizData = try container.viewContext.fetch(request)
            let model = QuizModel()
            //transformation to native struct
            
            return Result.success(model)
        } catch {
            return Result.failure(error)
        }
    }
    
    func saveQuizData(model: QuizModel, handler: @escaping (Bool) -> Void) {
        do {
            let request = NSFetchRequest<QuizUserData>()
            let quizData = try container.viewContext.fetch(request)
            
            guard quizData.count <= 1 else {
                handler(false)
                return
            }
            
            if let quiz = quizData.first {
                configureQuiz(quiz, fromModel: model)
                try container.viewContext.save()
                handler(true)
            } else {
                guard let newQuiz = NSEntityDescription.insertNewObject(forEntityName: "QuizUserData", into: container.viewContext) as? QuizUserData else {
                    handler(false)
                    return
                }
                configureQuiz(newQuiz, fromModel: model)
                try container.viewContext.save()
                handler(true)
            }
        } catch {
            DispatchQueue.main.async {
                handler(false)
            }
        }
    }
    
    func saveBluetoothData(model: BluetoothModel, handler: @escaping (Bool) -> Void) {
        do {
            let request = NSFetchRequest<BluetoothUserData>()
            let bluetoothData = try container.viewContext.fetch(request)
            
            guard bluetoothData.count <= 1 else {
                handler(false)
                return
            }
            
            if let bluetooth = bluetoothData.first {
                configureBluetooth(bluetooth, fromModel: model)
                try container.viewContext.save()
                handler(true)
            } else {
                guard let newBluetooth = NSEntityDescription.insertNewObject(forEntityName: "BluetoothUserData", into: container.viewContext) as? BluetoothUserData else {
                    handler(false)
                    return
                }
                configureBluetooth(newBluetooth, fromModel: model)
                try container.viewContext.save()
                handler(true)
            }
        } catch {
            DispatchQueue.main.async {
                handler(false)
            }
        }
    }
    
    //TODO: - Fill the functions
    
    private func configureQuiz(_ quiz: QuizUserData, fromModel model: QuizModel) {
        
    }
    
    private func configureBluetooth(_ bluetooth: BluetoothUserData, fromModel model: BluetoothModel) {
        
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
