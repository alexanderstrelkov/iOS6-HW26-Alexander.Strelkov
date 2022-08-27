//
//  Assembly.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 25.08.2022.
//

import Foundation
import UIKit

// MARK: - ModuleAssemblyProtocol

protocol ModuleAssemblyProtocol {
    func createUsersModule()
//    func createDetailedUserModule(user: User?) -> UIViewController
}

//MARK: - AssemblyModule

//class AssemblyModule: ModuleAssemblyProtocol {
//    func createUsersModule() {
//        let view = UsersViewController()
//        let presenter = UsersPresenter(userDataManager: UserDataManager.instance)
//        view.presenter = presenter
//    }
//    func createDetailedUserModule(router: UsersRouterProtocol, user: User?) -> UIViewController {
//        let view = DetailedUserViewController()
//        let presenter = DetailedUserPresenter(view: view,
//                                              coreDataService: CoreDataService.sharedManager,
//                                              router: router,
//                                              user: user)
//        view.presenter = presenter
//        return view
//    }
//}
