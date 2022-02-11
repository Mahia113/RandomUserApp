//
//  RUJManager.swift
//  RandomUserJusto
//
//

import Foundation
import Combine
import UIKit

public struct RUJManager {
    
    init() {}
    
    public func RandomUserManager() -> RandomUserManager {
        let rdm = RandomUserJusto.RandomUserManager(client: self)
        return rdm
    }
    
}
