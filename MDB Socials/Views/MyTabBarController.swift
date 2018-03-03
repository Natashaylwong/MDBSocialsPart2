//
//  MyTabBarController.swift
//  MDB Socials
//
//  Created by Natasha Wong on 3/3/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let attrs = [
//            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)
//        ]
//        UITabBarItem.appearance().setTitleTextAttributes(attrs, for: .normal)
//        super.viewDidLoad()
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedStringKey.font:UIFont(name: "Strawberry Blossom", size: 18)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        let tabOne = FeedViewController()
        let image1 = UIImage(named: "feed")
        tabOne.tabBarItem = UITabBarItem(title: "Main Feed", image: image1, tag: 0)
        let tabTwo = MyEventsViewController()
        let image2 = UIImage(named: "event")
        tabTwo.tabBarItem = UITabBarItem(title: "My Events", image: image2, tag: 1)
        self.viewControllers = [tabOne, tabTwo]
    }
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 70
        tabFrame.origin.y = self.view.frame.size.height - 70
        self.tabBar.frame = tabFrame
    }
}
