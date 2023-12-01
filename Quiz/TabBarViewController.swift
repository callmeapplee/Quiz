//
//  TabBarViewController.swift
//  Quiz
//
//  Created by Ботурбек Имомдодов on 01/12/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let myProfileTabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        let usersTabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let profileVC = UINavigationController(rootViewController:  ProfileViewController())
        let userVC = UINavigationController(rootViewController:  UsersViewController())
        userVC.tabBarItem = usersTabBarItem
        profileVC.tabBarItem = myProfileTabBarItem
        self.viewControllers = [userVC,profileVC]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
