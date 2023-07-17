//
//  SearchPhotosApiService.swift
//  minstagram
//
//  Created by Julien Delferiere on 16/07/2023.
//

import Combine
import Foundation

final actor SearchPhotosApiService: BaseApiServiceProtocol {
    typealias DataType = PhotosEntity
    
    @Published var dataState: DataState<DataType> = .noneState
    
    unowned let networkAgent: NetworkAgent
    
    init(networkAgent: NetworkAgent) {
        self.networkAgent = networkAgent
    }
    
    func search(query: String) async {
        self.dataState = await self.fetchData(
            endPoint: PhotosEndPoints.search(
                query: query,
                perPage: 10
            )
        )
    }
}
