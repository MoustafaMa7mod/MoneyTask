//
//  MoneyAppViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import UIKit

class MoneyAppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithDefaultBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white , .font: UIFont.systemFont(ofSize: 17.0)]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white , .font: UIFont.systemFont(ofSize: 34.0)]
            navBarAppearance.backgroundColor = Colors.mainColor
            navBarAppearance.shadowColor = .white
            UINavigationBar.appearance().tintColor = .white
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        }else{
            self.view.backgroundColor = Colors.mainColor
            self.navigationBar.backgroundColor = Colors.mainColor
            self.navigationBar.barTintColor = Colors.mainColor
            self.navigationBar.tintColor = .white
            let paragraph = NSMutableParagraphStyle()
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.paragraphStyle :paragraph ,NSAttributedString.Key.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)]
            self.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white
                                                            , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34.0)]
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
        }
        
    }
    
    
}
