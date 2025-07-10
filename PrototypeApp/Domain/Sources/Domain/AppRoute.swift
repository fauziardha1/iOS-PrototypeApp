//  AppRoute.swift
//  Domain Layer - Navigation
//
//  Defines navigation routes for the app, independent of UI frameworks.

public enum AppRoute {
    case login
    case home
    case profile
    case settings
    case changePassword
    // Add more cases as app grows
}

public enum AppMainMenu: CaseIterable {
    case home
    case profile
    case settings
    
    public static func getRawValue(of type: AppMainMenu) -> String {
        switch type {
            case .home: return "Home"
            case .profile: return "Profile"
            case .settings: return "Setting"
        }
    }
}
