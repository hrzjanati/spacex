//
//  DependecyInjector.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/3/22.
//

import Foundation
import Swinject

@propertyWrapper

struct Inject<Component> {
    let wrappedValue: Component
    init() {
        self.wrappedValue = Resolver.shared.resolve(Component.self)
    }
}

class Resolver {
    static let shared = Resolver()
    private var container = DIContainer()

    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }

    func setDependencyContainer(_ container: Container) {
        self.container = container
    }
}


private func DIContainer() -> Container {
    let container = Container()
    
    container.register(HomeProviding.self) { _ in
        HomeProvider()
    }.inObjectScope(.container)
    
    container.register(Home.ViewModel.self) { _ in
        Home.ViewModel()
    }.inObjectScope(.container)
    
    return container
}
