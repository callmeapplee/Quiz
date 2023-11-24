//
//  UsersViewController.swift
//  Quiz
//
//  Created by Ботурбек Имомдодов on 18/11/23.
//

import UIKit
class UsersViewController: UIViewController {
    var users:[User] = []
    private  var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
        FirestoreService.shared.getUsers { [weak self] users in
            self?.users = users
            self?.tableView.reloadData()
        }
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
extension UsersViewController:UITableViewDataSource{
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
