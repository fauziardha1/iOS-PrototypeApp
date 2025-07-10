//
//  MasterViewModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 10/07/25.
//

class MenuViewModel {
    var menus: [String] = []
    var view: MenuDisplayLogic?
    var getMenus: () -> [String] = {[]}
    var actionNavigateTo: (Int) -> Void = {_ in }
    
    func loadMenus() {
        self.menus = getMenus()
        view?.load(menus: menus)
    }
    
    func navigateTo(_ index: Int) {
        actionNavigateTo(index)
    }
}
