//
//  Application.swift
//  pmToolMobile
//
//  Created by Sachin on 16/08/23.
//

import SwiftUI
import UIKit
import Firebase

final class Application_utility {
    static var  rootViewController:UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else
        {
            return .init()
        }
        return root
    }
  
}


