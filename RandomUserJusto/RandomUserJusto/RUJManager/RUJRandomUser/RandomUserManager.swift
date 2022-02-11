//
//  RandomUserManager.swift
//  RandomUserJusto
//
//

import Foundation
import Combine
import UIKit

public struct RandomUserManager {
    
    private let client: RUJManager
    private let URL = "https://randomuser.me/api/"
    private let networkHandler: NetworkHandler = NetworkHandler()
    
    public init(client: RUJManager){
        self.client = client
    }
    
    func getRandomUserData() -> Future <RandomUserModel, Error> {
        return Future() { promise in
            
            networkHandler.performAPIRequestByURL(url: URL) {
                switch $0 {
                    case .success(let data):
                        if let RandomUserData: ResponseRandomUser = self.networkHandler.decodeJSONData(data: data){
                            let user =  RandomUserData.results.first
                            
                            promise(.success(user!))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                }
            }
            
        }
    }
    
}
