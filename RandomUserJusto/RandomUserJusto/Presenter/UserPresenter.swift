//
//  UserPresenter.swift
//  RandomUserJusto
//
//

import UIKit
import Combine

protocol UserViewControllerDelegate: NSObjectProtocol {
    func displayUserData(data: RandomUserModel)
    func displayUserImage(image: Data)
    func errorFetchingUserData(error: Error)
}

class UserPresenter {
    
    weak private var userViewControllerDelegate: UserViewControllerDelegate?
    let rujManager = RUJManager()
    var cancellable: AnyCancellable?

    init() {}
    
    func setViewDelegate(userViewControllerDelegate: UserViewControllerDelegate?){
        self.userViewControllerDelegate = userViewControllerDelegate
    }
    
    func getUserData(){
        cancellable = rujManager.RandomUserManager().getRandomUserData().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.userViewControllerDelegate?.errorFetchingUserData(error: error)
            case .finished:
                break
            }
        }, receiveValue: { randomUser in
            self.userViewControllerDelegate?.displayUserData(data: randomUser)
        })
    }
    
    func downloadUserImage(url: String){
        
        let imageURL = URL(string: url)!
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            self.userViewControllerDelegate?.displayUserImage(image: data!)
        }
        
    }
    
}
