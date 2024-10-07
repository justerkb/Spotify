//
//  SettingsVC.swift
//  Spotify
//
//  Created by Yerkebulan on 09.09.2024.
//

import Foundation
import UIKit
class SettingsVC: UIViewController {
    
    private var options = [
        Option(title: "Account", vc: UserProfileVC()),
        Option(title: "Data Saver", vc: myVC()),
        Option(title: "Languages", vc: myVC()),
        Option(title: "Devices", vc: myVC()),
        Option(title: "Car", vc: myVC()),
        Option(title: "Storage", vc: myVC()),
        Option(title: "Notifications", vc: myVC()),
        Option(title: "Local Files", vc: myVC()),
        Option(title: "About", vc: myVC())
    ]
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .primary
        tableView.register(SettingsOptionCell.self, forCellReuseIdentifier: SettingsOptionCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primary
        view.safeAreaLayoutGuide.owningView?.backgroundColor = .systemGray5
        tableView.dataSource = self
        tableView.delegate = self
        title = "Settings"

        
        setupTableView()
        createTableHeader()
    }
    
    //MARK: - Private
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createTableHeader() {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 90))
        
        if let imageData = UserDefaults.standard.object(forKey: "AvatarImage") {
            headerView.configure(imageData: imageData as! Data)
        }
                
        tableView.tableHeaderView = headerView
    }
    
}
//MARK: - TableView func.
extension SettingsVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsOptionCell.identifier, for: indexPath) as? SettingsOptionCell else {
            fatalError("unable create cell")
            
        }
        let title = options[indexPath.row].title
        cell.configure(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        self.navigationController?.pushViewController(option.vc, animated: true)
    }
    
}

//MARK: - Preview
#Preview {
    UINavigationController(rootViewController: SettingsVC())
}

