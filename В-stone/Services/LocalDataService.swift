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
            let request = NSFetchRequest<BluetoothUserData>(entityName: "BluetoothUserData")
            let bluetoothData = try container.viewContext.fetch(request)
            guard let bluetooth = bluetoothData.first else { throw SuperError.NothingIsStored }
            guard let dataArray = bluetooth.data else { throw SuperError.DataIsNotStored }
            let newArray = NSKeyedUnarchiver.unarchiveObject(with: dataArray) as! [[Any]]
            let model = BluetoothModel(prevPercentage: bluetooth.prevPercantage, prevDate: bluetooth.prevDate, currentPercentage: bluetooth.currentPercentage, date: bluetooth.currentDate, data: newArray)

            //transformation to native struct

            return Result.success(model)
        } catch {
            return Result.failure(error)
        }
    }
    
    func fetchQuizData() -> Result<QuizModel> {
        do {
            let request = NSFetchRequest<QuizUserData>(entityName: "QuizUserData")
            let quizData = try container.viewContext.fetch(request)
            guard let quiz = quizData.first else { throw SuperError.NothingIsStored }
            //transformation to native struct
            let model = QuizModel(age: Int(quiz.age), allergic: Allergic(rawValue: (quiz.allergic)!), placeOfLiving: PlaceOfLiving(rawValue: (quiz.placeOfLiving)!), habitCoffee: quiz.habitCoffee, habitDiet: quiz.habitDiet, habitMakeup: quiz.habitMakeup, habitSmoking: quiz.habitSmoking, habitTravelling: quiz.habitTravelling, habitSunbathing: quiz.habitSunbathing, inflamationsAroundNose: quiz.inflamationsNose, inflamationsCheeks: quiz.inflamationsCheeks, inflamationsChin: quiz.inflamationsChin, inflamationsForehead: quiz.inflamationsForehead, inflamationsNose: quiz.inflamationsNose, wrinklesForehead: quiz.wrinklesForehead, wrinklesInterbrow: quiz.wrinklesInterbrow, wrinklesSmile: quiz.wrinklesSmile, wrinklesUnderEye: quiz.wrinklesUnderEye)
            
            return Result.success(model)
        } catch {
            return Result.failure(error)
        }
    }
    
    func saveQuizData(model: QuizModel, handler: ((Bool) -> Void)?) {
        do {
            let request = NSFetchRequest<QuizUserData>(entityName: "QuizUserData")
            let quizData = try container.viewContext.fetch(request)
            
            guard quizData.count <= 1 else {
                handler?(false)
                return
            }
            
            if let quiz = quizData.first {
                configureQuiz(quiz, fromModel: model)
                try container.viewContext.save()
                handler?(true)
            } else {
                guard let newQuiz = NSEntityDescription.insertNewObject(forEntityName: "QuizUserData", into: container.viewContext) as? QuizUserData else {
                    handler?(false)
                    return
                }
                configureQuiz(newQuiz, fromModel: model)
                try container.viewContext.save()
                handler?(true)
            }
        } catch {
            DispatchQueue.main.async {
                handler?(false)
            }
        }
    }
    
    func saveBluetoothData(model: BluetoothModel, handler: ((Bool) -> Void)?) {
        do {
            let request = NSFetchRequest<BluetoothUserData>(entityName: "BluetoothUserData")
            let bluetoothData = try container.viewContext.fetch(request)
            
            guard bluetoothData.count <= 1 else {
                handler?(false)
                return
            }
            
            if let bluetooth = bluetoothData.first {
                configureBluetooth(bluetooth, fromModel: model)
                try container.viewContext.save()
                handler?(true)
            } else {
                guard let newBluetooth = NSEntityDescription.insertNewObject(forEntityName: "BluetoothUserData", into: container.viewContext) as? BluetoothUserData else {
                    handler?(false)
                    return
                }
                configureBluetooth(newBluetooth, fromModel: model)
                try container.viewContext.save()
                handler?(true)
            }
        } catch {
            DispatchQueue.main.async {
                handler?(false)
            }
        }
    }
    
    //TODO: - Fill the functions
    
    private func configureQuiz(_ quiz: QuizUserData, fromModel model: QuizModel) {
        quiz.age = Int16(model.age)
        quiz.allergic = model.allergic?.rawValue
        
        quiz.placeOfLiving = model.placeOfLiving?.rawValue
        
        quiz.habitCoffee = model.habitCoffee
        quiz.habitDiet = model.habitDiet
        quiz.habitTravelling = model.habitTravelling
        quiz.habitMakeup = model.habitMakeup
        quiz.habitSmoking = model.habitSmoking
        quiz.habitSunbathing = model.habitSunbathing
        
        quiz.inflamationsAroundNose = model.inflamationsAroundNose
        quiz.inflamationsForehead = model.inflamationsForehead
        quiz.inflamationsChin = model.inflamationsChin
        quiz.inflamationsCheeks = model.inflamationsCheeks
        quiz.inflamationsNose = model.inflamationsNose
        
        quiz.wrinklesForehead = model.wrinklesForehead
        quiz.wrinklesUnderEye = model.wrinklesUnderEye
        quiz.wrinklesInterbrow = model.wrinklesInterbrow
        quiz.wrinklesSmile = model.wrinklesSmile
    }
    
    private func configureBluetooth(_ bluetooth: BluetoothUserData, fromModel model: BluetoothModel) {
        bluetooth.currentDate = model.date
        bluetooth.currentPercentage = model.currentPercentage!
        bluetooth.prevDate = model.prevDate
        bluetooth.prevPercantage = model.prevPercentage!
        let data = NSKeyedArchiver.archivedData(withRootObject: model.data)
        bluetooth.data = data
    }
    
    func cleanStorage() {
        do {
            let qRequest = NSFetchRequest<QuizUserData>(entityName: "QuizUserData")
            let quizData = try container.viewContext.fetch(qRequest)
            guard let quiz = quizData.first else { return }
            
            let blRequest = NSFetchRequest<BluetoothUserData>(entityName: "BluetoothUserData")
            let bluetoothData = try container.viewContext.fetch(blRequest)
            guard let bluetooth = bluetoothData.first else { return }
            
            container.viewContext.delete(quiz)
            container.viewContext.delete(bluetooth)
        } catch {
            print(error)
        }
        
        
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum SuperError: Error {
    case NothingIsStored
    case DataIsNotStored
}
