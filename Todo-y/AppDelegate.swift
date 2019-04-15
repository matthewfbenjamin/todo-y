//
//  AppDelegate.swift
//  Todo-y
//
//  Created by Benjamin, Matthew on 4/11/19.
//  Copyright © 2019 Benjamin, Matthew. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation1 = UINavigationController()
        navigation1.navigationBar.tintColor = UIColor.white
        navigation1.navigationBar.barTintColor = UIColor.init(red: 66 / 255, green: 134 / 255, blue: 244 / 255, alpha: 1.0)

//        let todoListViewController = TodoListViewController(nibName: nil, bundle: nil)
        let categoryViewController = CategoryTableViewController()

        navigation1.viewControllers = [categoryViewController]
        window!.rootViewController = navigation1
        window!.makeKeyAndVisible()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }



}

