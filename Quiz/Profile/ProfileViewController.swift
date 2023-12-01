//
//  ProfileViewController.swift
//  Quiz
//
//  Created by Ботурбек Имомдодов on 24/11/23.
//

import UIKit

class ProfileViewController: UIViewController {
    var users:[User] = []
    private  var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои викторины"
        let leftBarButton = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        leftBarButton.tintColor = .red
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = leftBarButton
        self.view.backgroundColor = .white
        setupTableView()
        FirestoreService.shared.getUsers { [weak self] users in
            self?.users = users.filter({ user in
                return AuthService.shared.currentUser.uid == user.id
            })
            self?.tableView.reloadData()
        }
    }
    @objc func rightBarButtonTapped() {
        let alert = UIAlertController(title: "Вы точно хотите выйти?", message: "Подтвердите свое действие", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Подтвердить", style: .destructive) { _ in
            do {
                try AuthService.shared.signOut()
                self.tabBarController?.navigationController?.setViewControllers([AuthViewController()], animated: true)
            }
            catch(let error){
                print(error.localizedDescription)
            }
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    private func setupTableView(){
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                    ])
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
extension ProfileViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell content directly
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = users[indexPath.row].name
        contentConfig.secondaryText = "количество викторин: \(users[indexPath.row].quizzes.count) "
        cell.contentConfiguration = contentConfig
        return cell
    }
    
}
