//
//  RestAPIManager.swift
//  SwiftUIJsonParsing
//
//  Created by Yugandhar Kommineni on 11/12/21.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var fetchUsers: [UserModel]?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchUserData()
    }
    
    func fetchUserData() {
        guard let userUrl = URL(string: "https://jsonplaceholder.typicode.com/users") else { return  }
        
        /* 1. create publisher
         2. subscribe publisher on background thread
         3. receive on main thread
         4. trtMap check data is good
         5. decode the data in to fetchUsers
         6. sink put the data in to our app
         7. store and cancel the subscription
         */
        
        
        URLSession.shared.dataTaskPublisher(for: userUrl)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main, options: nil)
            .tryMap({ (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                          throw URLError(.badServerResponse)
                      }
                return data
            }).decode(type: Welcome.self, decoder: JSONDecoder())
            .sink { (completion) in
                print(completion)
            } receiveValue: { [weak self] (userDetails) in
                self?.fetchUsers = userDetails
            }
            .store(in: &cancellables)
    }
}
