//
//  ContentViewModel.swift
//  AlertKitDemo
//
//  Created by Alex Nagy on 27.12.2020.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    func fetchData(completion: @escaping (Result<Bool, Error>) -> ()) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 4) {
            DispatchQueue.main.async {
//                completion(.success(true))
                completion(.success(false))
//                completion(.failure(NSError(domain: "Could not fetch data", code: 404, userInfo: nil)))
            }
        }
    }
}
