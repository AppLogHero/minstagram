//
//  BaseViewModel.swift
//  minstagram
//
//  Created by Julien Delferiere on 17/07/2023.
//

import Foundation

enum ViewState<Model> {
    case empty(_ model: EmptyViewModel)
    case loading
    case loaded(_ model: Model)
    case error(_ model: ErrorViewModel)
}

struct EmptyViewModel {
    let title: String
    let description: String
}

struct ErrorViewModel {
    let title: String
    let description: String
    let errorMode: ErrorMode
}

enum ErrorMode {
    case popUp(actions: [ActionModel])
    case fullScreen
}

struct ActionModel {
    let label: String
    let action: () -> Void
}

class ViewStateViewModel<Model>: ObservableObject {
    
}
