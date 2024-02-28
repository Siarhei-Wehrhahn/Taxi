//
//  ViewRouter.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 26.02.24.
//

import Foundation

enum Page {
    case splash
    case home
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .splash
}
