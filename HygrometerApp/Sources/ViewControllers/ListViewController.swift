//
//  ListViewController.swift
//  HygrometerApp
//
//  Created by 홍승현 on 2022/07/09.
//
import SnapKit
import UIKit

class ListViewController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel = ListViewModel()

    lazy var weatherListTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(WeatherListTableViewCell.self, forCellReuseIdentifier: "WeatherListTableViewCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLayouts()
        setupConstraints()
        self.view.backgroundColor = .systemTeal
        viewModel.setup() { [weak self] in
            self?.weatherListTableView.reloadData()
        }
    }
    
       
    // MARK: - Configuration
    
    private func setupLayouts() {
        self.view.addSubview(weatherListTableView)
    }
    
    private func setupConstraints() {
        weatherListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.shared.items.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListTableViewCell", for: indexPath) as! WeatherListTableViewCell

        if indexPath.row == UserData.shared.items.count {
            cell.humidityLabel.isHidden = true
            cell.locationNameLabel.isHidden = true
            cell.plusView.isHidden = false
            return cell
        }
        
        let model = viewModel.models[indexPath.row]
        cell.configure(with: model)
        cell.plusView.isHidden = true
        
        return cell
    }
    
    
}
