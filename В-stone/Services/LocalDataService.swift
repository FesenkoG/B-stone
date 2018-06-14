//
//  LocalDataService.swift
//  В-stone
//
//  Created by Георгий Фесенко on 11.06.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import Foundation
import CoreData

class LocalDataService {
    lazy var container = NSPersistentContainer(name: "DataModel")
    
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
            let bluetoothData = try container.viewContext.fetch(request)
            let model = QuizModel()
            //transformation to native struct
            return Result.success(model)
        } catch {
            return Result.failure(error)
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
